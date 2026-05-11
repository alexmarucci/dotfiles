---
name: fix-mr-pipeline
description: Fix a failed GitLab pipeline for a given MR. Uses a sub-agent for discovery, main agent for the fix.
metadata:
  short-description: Fix failed pipeline for an MR
---

# Fix MR Pipeline

Fix a failed GitLab CI pipeline for a specific MR. Uses a sub-agent for discovery so the main context stays clean.

Works in CWD — assumes you're on the right repo and branch.

## Prerequisites

- `glab` CLI authenticated
- `node` installed
- `GITLAB_TOKEN` env var set (or `GITLAB_NPM_TOKEN` as fallback)
- Scripts at `~/.claude/skills/fix-mr-pipeline/scripts/`

## Resources

- Bundled scripts in `./scripts`

## Input

The user provides an MR IID (e.g. `/fix-mr-pipeline 123`).

If no IID given, ask: "Which MR IID should I fix the pipeline for?"

## Step 1: Dispatch Discovery Sub-Agent

Use the Agent tool with `subagent_type: Explore` to gather all pipeline failure context. Do NOT do discovery yourself.

Spawn the agent with this prompt:

```
You are investigating a failed GitLab CI pipeline for MR !{MR_IID}.

Run all bash commands with elevated network access (dangerouslyDisableSandbox: true).

### 1. Get project info

```bash
glab repo view -F json | jq '{id: .id, path: .pathWithNamespace}'
```

### 2. Get MR details

```bash
glab mr view {MR_IID} -F json | jq '{iid, title, source_branch, target_branch, web_url}'
```

### 3. Check pipeline status

```bash
PROJECT_ID=$(glab repo view -F json | jq -r '.id')
export GITLAB_TOKEN="${GITLAB_TOKEN:-$GITLAB_NPM_TOKEN}"
node ~/.claude/skills/fix-mr-pipeline/scripts/check-pipeline-status.js $PROJECT_ID {MR_IID}
```

If status is SUCCESS or RUNNING — report that and stop.

### 4. If FAILED — fetch failed jobs

Extract PIPELINE_ID from the JSON output after `---JSON---` in step 3.

```bash
node ~/.claude/skills/fix-mr-pipeline/scripts/fetch-pipeline-jobs.js $PROJECT_ID $PIPELINE_ID
```

If the script fails, use glab fallback:

```bash
PROJECT_PATH=$(glab repo view -F json | jq -r '.pathWithNamespace')
glab api "projects/${PROJECT_PATH//\//%2F}/pipelines/$PIPELINE_ID/jobs" | jq '[.[] | select(.status=="failed")]'
glab api "projects/${PROJECT_PATH//\//%2F}/jobs/$JOB_ID/trace" | tail -150
```

### 5. Get MR diff summary

```bash
TARGET_BRANCH=$(glab mr view {MR_IID} -F json | jq -r '.target_branch')
git fetch origin $TARGET_BRANCH 2>/dev/null || git fetch origin main
git diff --stat origin/$TARGET_BRANCH...HEAD
```

Also read any files that appear in the failed job traces to understand the context.

### Report back

Return a structured report with:

1. **MR info**: title, source branch, target branch
2. **Pipeline status**: current status and pipeline ID
3. **Failed jobs**: for each failed job:
   - Name and stage
   - Failure reason
   - Relevant trace excerpt (the actual error, not all 150 lines)
   - Web URL
4. **Diff summary**: files changed in the MR
5. **Root cause hypothesis**: based on mapping the error to the changed files

Be thorough on the traces — include enough context for someone to understand the error without seeing the full log.
```

Wait for the sub-agent to return its report.

## Step 2: Review Discovery Report

Read the sub-agent's report. If pipeline is not failed, inform the user and stop.

If FAILED, review:
- The failed job names and traces
- The diff summary
- The root cause hypothesis

Verify the hypothesis makes sense by reading the relevant files in the diff.

## Step 3: Fix

1. **Use `superpowers:systematic-debugging`** if the root cause isn't obvious.

2. **Implement the fix** — edit the relevant files.

3. **Run relevant tests locally** if possible before committing.

## Step 4: Confirm to user 
Confirm the user the fixes have been made

```

fix: resolve <job-name> pipeline failure

<brief description of what was wrong and what changed>

## Step 5: Monitor Pipeline

After push, poll for the pipeline result:

```bash
PROJECT_ID=$(glab repo view -F json | jq -r '.id')
export GITLAB_TOKEN="${GITLAB_TOKEN:-$GITLAB_NPM_TOKEN}"
node ~/.claude/skills/fix-mr-pipeline/scripts/check-pipeline-status.js $PROJECT_ID $MR_IID
```

Check every 2 minutes until:
- SUCCESS → done, inform user
- FAILED again → dispatch a new discovery sub-agent with the new pipeline ID, go back to Step 2. Max 3 attempts total.
- Still RUNNING → keep polling

Use `/loop 2m` to set up polling if the user wants async monitoring.

## Error Handling

| Error | Action |
|-------|--------|
| `glab` not authenticated | Tell user to run `glab auth login` |
| `GITLAB_TOKEN` missing | Check for `GITLAB_NPM_TOKEN` fallback, else tell user to set it |
| Branch not found | `git fetch --all` then retry |
| Push rejected | Alert user to resolve conflicts |
| 3 fix attempts exceeded | Stop, present analysis to user for manual intervention |
| Scripts not found | Fallback to glab CLI commands |

## Common Mistakes

- **Doing discovery yourself** — always delegate to the sub-agent, keep main context for fixing
- **Fixing wrong branch** — verify current branch matches MR source branch before editing
- **Ignoring test context** — read the full trace, not just the last error line
- **Fixing symptoms not cause** — use systematic debugging, don't just patch error messages
- **Pushing without testing locally** — run relevant tests first when possible
