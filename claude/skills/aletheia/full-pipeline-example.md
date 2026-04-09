# Example: Full Pipeline Run

This example shows what the Aletheia harness looks like in practice, using a 
real-world task from a Fastify + Prisma backend.

## User Invocation

```
/aletheia Build SSE streaming endpoint for Claude API responses with rate limiting,
abort support, and conversation persistence
```

## Phase 1: Planner Output

The planner expands this into a spec and writes it to `.aletheia/spec.md`:

```markdown
# SSE Streaming Endpoint for Claude API

## Overview
A Fastify route handler that streams Claude API responses to the frontend via 
Server-Sent Events, with rate limiting per user tier, client-side abort support, 
and conversation persistence to PostgreSQL.

## Functional Requirements
- POST /api/chat/stream accepts message text and conversation ID
- Validates JWT session from cookie
- Checks per-user rate limits (configurable by subscription tier)
- Calls Claude API with streaming enabled
- Streams response chunks as SSE events to the client
- Supports client-initiated stream abortion via AbortController
- Saves complete assistant response to database after stream completes
- Returns appropriate error events for auth failures, rate limits, API errors

## Non-Functional Requirements
- Sub-200ms time to first SSE event after Claude API responds
- Rate limit state in Redis (not in-memory) for multi-instance support
- Graceful handling of Claude API outages (retry once, then error event)
- No partial responses persisted on abort — only complete messages saved

## Technical Approach
- Fastify with reply.raw for SSE (standard reply doesn't support streaming)
- Claude API SDK with streaming enabled
- Redis for rate limit counters with sliding window
- Prisma for conversation/message persistence
- AbortController signal propagated to Claude API call

## Edge Cases
- User aborts mid-stream: cleanup Claude API connection, don't save partial
- Rate limit hit during active stream: should not happen (checked before stream starts)
- JWT expired during stream: complete current stream, reject next request
- Claude API returns error mid-stream: send error SSE event, close connection
- Database write fails after stream: log error, return success (message was delivered)
- Concurrent requests from same user: allow (rate limit handles abuse)

## Out of Scope
- WebSocket alternative (SSE is the chosen protocol)
- Message editing or regeneration (separate endpoint)
- File/image attachments in messages
```

## Phase 2: Generator

The generator builds the implementation based on the spec. Produces the route handler,
rate limiting middleware, SSE utility, and Prisma schema additions.

## Phase 3: Evaluator

### Step 1: Blind Pre-Analysis (before seeing the code)

The evaluator subagent receives the spec but has never seen the generator's code or
reasoning. It reasons about what correct behavior looks like:

"For an SSE streaming endpoint with these requirements, correct behavior means:

1. A POST to /api/chat/stream with a valid JWT and message body should begin emitting
   SSE events within 200ms of the Claude API responding. Each chunk should arrive as a
   properly formatted `data:` event.

2. Rate limiting: a user who has made N requests in the last M seconds (where N and M
   depend on their tier) should receive a 429 response BEFORE any streaming begins.
   Critical: this must be a sliding window, not a fixed window — otherwise 2x burst
   is possible at window boundaries.

3. Abort: if the client disconnects mid-stream, the Claude API call must be cancelled
   (no wasted compute) and no partial message should be persisted to the database.

4. Persistence: only complete assistant responses should be saved. A stream that errors
   mid-way should not leave a partial message in the database.

5. Common mistakes on this type of task:
   - Forgetting to close the HTTP response on error paths (connection hangs)
   - Not handling backpressure (client slower than API)
   - Saving messages inside the stream loop instead of after completion
   - Not cleaning up event listeners on abort (memory leak on repeated disconnect)

6. A fundamentally WRONG implementation would use polling, lose messages, or persist
   partial responses."

### Step 2: Evaluation (after seeing the code — still within the subagent)

"Comparing against my independent behavioral expectations:
- ✓ SSE events emit correctly with proper Content-Type and formatting
- ✗ Rate limiter uses simple counter in Redis (INCR/EXPIRE), not sliding window.
    Tested: 10 requests at window boundary → allowed 20 total. Fails sliding window requirement.
- ✗ Client disconnect triggers controller.abort() but 'data' event listener on the
    Claude stream is not removed. Tested: connect/disconnect 50x → listener count grows.
- ✓ Message saved after stream completion, not during
- ✗ Rate limit exceeded path writes error SSE event but never calls reply.raw.end().
    Tested: trigger rate limit → connection hangs indefinitely."

### Step 3: Criteria Grades

```
- Correctness:  MARGINAL — Core streaming works but rate limiter algorithm wrong
- Completeness: PASS — All spec requirements addressed
- Security:     PASS — JWT validation, input sanitization present
- Resilience:   FAIL — Missing cleanup on abort, missing reply.raw.end() on error
- Code Quality: PASS — Clean structure, good types, follows Fastify patterns
```

### Step 4: Verdict

```
FIXABLE

Issues:
1. [critical] src/routes/chat.ts:45 — Rate limiter uses INCR/EXPIRE (fixed window), 
   not ZADD/ZRANGEBYSCORE (sliding window). Sliding window prevents burst abuse at 
   window boundaries. → Switch to sorted set pattern.

2. [critical] src/routes/chat.ts:89 — reply.raw.end() not called when rate limit 
   is exceeded. Client connection will hang. → Add reply.raw.end() after writing 
   the error event.

3. [major] src/routes/chat.ts:112 — Client disconnect listener (req.raw.on('close')) 
   calls controller.abort() but doesn't remove the 'data' event listener on the 
   Claude stream. Memory leak on repeated abort/reconnect. → Store listener reference 
   and removeListener on close.
```

## Phase 4: Revision

Generator addresses all three issues in priority order, re-evaluation passes with 
CORRECT verdict.

## Final `.aletheia/log.md`

```markdown
# Aletheia Pipeline Log

Task: SSE streaming endpoint with rate limiting, abort, persistence
Mode: Full pipeline
Started: 2026-03-28T14:30:00

## Planner
- Spec written to .aletheia/spec.md
- 6 functional requirements, 4 non-functional, 6 edge cases identified

## Generator (Iteration 1)
- Files created: src/routes/chat.ts, src/middleware/rateLimit.ts, src/utils/sse.ts
- Self-evaluation: confident in implementation

## Evaluator (Iteration 1)
- Blind pre-analysis: identified 5 common mistakes for this task type
- Verdict: FIXABLE (1 critical, 1 critical, 1 major)

## Generator (Iteration 2 — Revision)
- Fixed: sliding window rate limiter
- Fixed: reply.raw.end() on error paths  
- Fixed: event listener cleanup on abort

## Evaluator (Iteration 2)
- Verdict: CORRECT
- All criteria: PASS

Total iterations: 2
Estimated duration: ~45 minutes
Estimated cost: ~$15-25
```
