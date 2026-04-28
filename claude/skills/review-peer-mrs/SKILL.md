---
name: review-peer-mrs
description: Use when you need to review merge requests from peers on GitLab - automates listing MRs awaiting your review, dispatches subagents to analyse diffs and provide feedback, then asks confirmation before posting comments via glab CLI
---

# Review Peer MRs

## Overview

Systematic workflow for reviewing peers' merge requests on GitLab using parallel subagents for efficient analysis and consolidated feedback before posting.

## When to Use

- User asks to review MRs, merge requests, or code reviews
- User wants to check what's awaiting their review
- User mentions "peer review", "code review", or "MR review"
- User asks about their GitLab review queue

## Resources

- Bundled resources in ./scripts

## Workflow

### Step 1: List MRs Awaiting Review

Run the following script to get a list of MRs awaiting your review:

```bash
scripts/mr-list-awaiting-review.js
```


### Step 2: Review Each MR with Subagents

For each MR found, dispatch a subagent to:

1. **Fetch MR details:**
   ```bash
   glab mr view <MR_ID>
   ```

2. **Get the diff:**
   ```bash
   glab mr diff <MR_ID>
   ```

3. **Get existing comments:**
   ```bash
   glab api projects/:id/merge_requests/<MR_IID>/notes
   ```

4. **Analyse and provide feedback based on:**
   - MR title and description
   - Code changes in the diff
   - Existing comments and discussions
   - Code quality, potential bugs, security issues
   - Test coverage
   - Documentation

### Step 3: Consolidate Feedback Overview

After all subagents complete, provide a summary:
- List of MRs reviewed
- Key findings for each
- Suggested comments organised by MR
- Priority of issues (critical, important, minor)

## Quick Reference

| Action | Command |
|--------|---------|
| List MRs awaiting review | `glab mr list --reviewer=@me --state=opened` |
| View MR details | `glab mr view <ID>` |
| Get MR diff | `glab mr diff <ID>` |
| Get MR comments | `glab api projects/:id/merge_requests/<IID>/notes` |

## Common Mistakes

- **Posting comments** - NEVER post comments
- **Reviewing own MRs** - Filter out your own authorship
- **Missing existing comments** - Check for prior discussions before posting
- **Vague feedback** - Be specific about file, line, and issue
- **Only criticising** - Acknowledge good changes too

## Parallel Review Pattern

When multiple MRs need review, dispatch subagents in parallel:

```
For each MR:
  - Spawn subagent with MR ID
  - Subagent fetches diff, title, description, existing comments
  - Subagent analyses and prepares feedback
  - Collect all results
  - Present consolidated overview
  - NEVER post any comments
```

## Red Flags - STOP and Confirm

- About to post comments
- Reviewing an MR you authored
- Addressing duplicate comments (check existing discussions)
- Unclear which file/line the comment refers to

**All of these mean: Stop and verify before proceeding.**
