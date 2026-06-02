---
name: autofix-ci-job
description: Automatically fix failing GitLab CI jobs by fetching logs, applying fixes, and polling until success
metadata:
  short-description: Auto-fix failing CI jobs
---

# Autofix CI Job

Automatically fix failing GitLab CI jobs. Fetches logs, diagnoses issues, applies fixes, commits safely, and polls until pipeline succeeds.

## Prerequisites

- `glab` CLI authenticated
- `node` installed (for helper scripts)
- `GITLAB_TOKEN` env var set
- Scripts at `~/.claude/skills/autofix-ci-job/scripts/`

## Input

User provides pipeline ID (e.g., `/autofix-ci-job 123456`).

If no pipeline ID given, detect from current branch's latest pipeline.

## Workflow

### Step 1: Discovery - Fetch Pipeline Context

Get project info, pipeline details, failed jobs, and logs:

```bash
# Get project ID
PROJECT_ID=$(glab repo view -F json | jq -r '.id')

# Get pipeline info
node ~/.claude/skills/autofix-ci-job/scripts/get-pipeline-info.js $PROJECT_ID {PIPELINE_ID}

# Fetch failed job logs
node ~/.claude/skills/autofix-ci-job/scripts/fetch-job-logs.js $PROJECT_ID {PIPELINE_ID}

# Fetch test report (if available)
node ~/.claude/skills/autofix-ci-job/scripts/fetch-test-report.js $PROJECT_ID {PIPELINE_ID}
```

**Report to user:**
- Pipeline status, web URL, duration
- Failed jobs: name, stage, error excerpt
- Test failures: test name, error message, file path
- Root cause analysis

### Step 2: Apply Fixes Locally

Based on failure type:

**Test failures:**
- Read test file to understand expectation
- Check code under test
- Fix either test or implementation
- Run tests locally if possible

**Type errors:**
- Find exact line from source map context
- Fix type annotation or value

**Lint errors:**
- Remove unused variable
- Or add eslint-disable comment if justified

**Runtime errors:**
- Analyse stack trace
- Fix code logic

Ask user to confirm fixes before proceeding.

### Step 3: Commit Safely

**Before pushing, verify commit safety:**

```bash
# Check commit count
COMMITS=$(git rev-list --count @{u}..@)
echo "Commits to push: $COMMITS"

# Verify commit message
git log -1 --format=%s
```

**Only push if:**
- Single commit AND
- Commit message matches: `fix: NOJIRA - fix pipeline`

Create commit if needed:

```bash
git add .
git commit -m "fix: NOJIRA - fix pipeline"
```

Push safely:

```bash
if [ "$COMMITS" -eq 1 ]; then
  git push
else
  echo "ERROR: Not safe to push - $COMMITS commits pending"
  exit 1
fi
```

### Step 4: Poll Until Success

**Check current time first:**

```bash
date '+%H:%M %d/%m/%Y'
```

**Calculate polling interval:**

```bash
# From pipeline info, get last job duration
JOB_DURATION_SECONDS=<duration>
POLL_INTERVAL=$((JOB_DURATION_SECONDS + 20))
echo "Poll interval: ${POLL_INTERVAL}s"
```

**Poll pipeline status:**

```bash
node ~/.claude/skills/autofix-ci-job/scripts/check-pipeline-status.js $PROJECT_ID {PIPELINE_ID}
```

**Polling logic:**
- SUCCESS → report success, stop
- FAILED → trigger new discovery cycle (max 3 attempts)
- RUNNING → continue polling

**Use CronCreate for long polling:**


```bash
# Calculate next check time
echo "Next check at: $(date -d '+${POLL_INTERVAL}s' '+%H:%M %d/%m/%Y')"
```

- Schedule recurring check
CronCreate cron="*/${POLL_INTERVAL}s * * * * *" prompt="check pipeline $PROJECT_ID $PIPELINE_ID" recurring=true

### Step 5: Handle Outcomes

**After SUCCESS:**
- Get final test report
- Show summary: tests fixed, time taken
- Stop polling

**After FAILED (retry):**
- Increment attempt counter
- If attempts < 5: go back to Step 1 with new pipeline ID
- If attempts >= 5: stop, report for manual review

**Timeout protection:**
- Max 3 fix attempts
- Max 1 hour total polling time
- Stop if pipeline manually cancelled

## Error Handling

| Error | Action |
|-------|--------|
| `glab` not authenticated | Tell user to run `glab auth login` |
| `GITLAB_TOKEN` missing | Tell user to set env var |
| No failed jobs | Report pipeline already passing |
| Multiple commits pending | Ask user to confirm push |
| Push rejected | Tell user to resolve conflicts |
| 3 attempts exceeded | Stop, report analysis |

## Common Patterns

**Test failure workflow:**
```bash
# From test report extract
test_name: "TestUserLogin"
error: "Expected 200, got 401"
file: "src/auth/login.test.ts"

# Fix approach
- Read test file: understand expectation
- Check code under test
- Fix either test or implementation
- Run test locally: npm test -- login.test.ts
```

**Type error workflow:**
```bash
# From job logs
error TS2345: Argument of type 'string' not assignable to 'number'
at src/service.ts:42:15

# Fix approach
- Read src/service.ts:42
- Fix type or value
- Verify: tsc --noEmit
```

## Safety Checks

**Before any push:**
1. Verify single commit (`git rev-list --count @{u}..@`)
2. Verify commit message pattern (`fix: NOJIRA - fix pipeline`)
3. Check for secrets in diff (`grep -i 'password\|token\|secret\|api_key'`)
4. Confirm if pushing to protected branch

**During polling:**
1. Check for new commits (avoid infinite loop)
2. Timeout after 1 hour
3. Stop if pipeline manually cancelled
