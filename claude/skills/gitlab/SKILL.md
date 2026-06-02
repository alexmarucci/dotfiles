---
name: gitlab
description: Reference skill — GitLab CLI commands, API calls, and bundled scripts for pipelines, MRs, jobs, and reviews. 
---

# GitLab Commands & Scripts

Reference sheet. No workflow. Run all `glab` commands with `dangerouslyDisableSandbox: true`.

## Prerequisites

- `glab` CLI authenticated (`glab auth login`)
- `node` installed
- `GITLAB_TOKEN` env var set (or `GITLAB_NPM_TOKEN` as fallback)
- Scripts at `~/.claude/skills/fix-mr-pipeline/scripts/` and `~/.claude/skills/autofix-ci-job/scripts/`

## Project & Repo

```bash
# Get project ID and path
glab repo view -F json | jq '{id: .id, path: .pathWithNamespace}'

# Get project info via script
node ~/.claude/skills/autofix-ci-job/scripts/get-pipeline-info.js $PROJECT_ID $PIPELINE_ID
```

## Merge Requests

```bash
# View MR details
glab mr view <MR_IID> -F json | jq '{iid, title, source_branch, target_branch, web_url}'

# Get MR diff summary
TARGET_BRANCH=$(glab mr view <MR_IID> -F json | jq -r '.target_branch')
git fetch origin $TARGET_BRANCH 2>/dev/null || git fetch origin main
git diff --stat origin/$TARGET_BRANCH...HEAD

# Get MR diff
glab mr diff <MR_IID>

# Fetch human comments (excl. bots and system notes)
glab mr view <MR_IID> -c -F json | jq '[.Discussions[] | .notes[] | select(
    ((.author.username // "" | test("bot"; "i") | not) or (.author.email // "" | length > 0)) and
    (.system // false | not) and
    (.type | IN("DiffNote", "DiscussionNote"))
  )]'

# Get MR notes via API
glab api projects/:id/merge_requests/<MR_IID>/notes

# List MRs awaiting your review
node ~/.claude/skills/review-peer-mrs/scripts/mrs-awaiting-review.js
```

## Pipelines

```bash
# Check pipeline status for an MR
PROJECT_ID=$(glab repo view -F json | jq -r '.id')
export GITLAB_TOKEN="${GITLAB_TOKEN:-$GITLAB_NPM_TOKEN}"
node ~/.claude/skills/fix-mr-pipeline/scripts/check-pipeline-status.js $PROJECT_ID <MR_IID>

# Check pipeline status by pipeline ID
node ~/.claude/skills/autofix-ci-job/scripts/check-pipeline-status.js $PROJECT_ID <PIPELINE_ID>

# Get full pipeline info (status, duration, failed jobs)
node ~/.claude/skills/autofix-ci-job/scripts/get-pipeline-info.js $PROJECT_ID <PIPELINE_ID>
```

## Jobs & Logs

```bash
# Fetch failed jobs for a pipeline (fix-mr-pipeline version)
node ~/.claude/skills/fix-mr-pipeline/scripts/fetch-pipeline-jobs.js $PROJECT_ID <PIPELINE_ID>

# Fetch failed job logs (autofix-ci-job version — includes duration)
node ~/.claude/skills/autofix-ci-job/scripts/fetch-job-logs.js $PROJECT_ID <PIPELINE_ID>

# Fallback: fetch jobs via glab API
PROJECT_PATH=$(glab repo view -F json | jq -r '.pathWithNamespace')
glab api "projects/${PROJECT_PATH//\//%2F}/pipelines/$PIPELINE_ID/jobs" | jq '[.[] | select(.status=="failed")]'

# Fallback: fetch job trace via glab API
glab api "projects/${PROJECT_PATH//\//%2F}/jobs/$JOB_ID/trace" | tail -150

# Fetch test report for a pipeline
node ~/.claude/skills/autofix-ci-job/scripts/fetch-test-report.js $PROJECT_ID <PIPELINE_ID>
```

## Git Operations for MRs

```bash
# Check commits pending push
COMMITS=$(git rev-list --count @{u}..@)
echo "Commits to push: $COMMITS"

# Verify commit message
git log -1 --format=%s

# Safe push check — only push if single commit
if [ "$COMMITS" -eq 1 ]; then
  git push
else
  echo "ERROR: Not safe to push - $COMMITS commits pending"
fi

# Fetch target branch for diff
git fetch origin <TARGET_BRANCH> 2>/dev/null || git fetch origin main
git diff --stat origin/<TARGET_BRANCH>...HEAD
```

## Datadog Logs for Failed Deployments

When job trace only shows high-level error (deploy/migration/ECS), actual error is in Datadog.

```bash
# Search Datadog logs for the failed deployment
pup logs search \
  --query="service:<service-name> env:<environment>" \
  --from="<job-start-time>" \
  --to="<job-finish-time>" \
  --limit=100

# Search by container_id for exact isolation
pup logs search \
  --query="container_id:<container-id>" \
  --from="<job-start-time>" \
  --to="<job-finish-time>"

# AWS CloudWatch fallback
aws logs describe-log-groups --log-group-name-prefix "/ecs/<cluster-name>"
aws logs filter-log-events --log-group-name "<log-group>" --start-time <epoch-ms> --end-time <epoch-ms>
```

Container ID format: `{task-id}-{container-id}` (e.g. `170ba971f8de4f438121db5f783a5d8e-0799205550`). First part = ECS task, second = container.

## Common Failure Patterns

| Pattern | Cause |
|---------|-------|
| `EHOSTUNREACH` / `ECONNREFUSED` | Database/service unreachable (check RDS/SG/VPC) |
| Migration SQL errors | Schema issues, check migration files in diff |
| OOM killed | Resource limits, check container memory |
| Timeout | Network or dependency issues |
| `TS2345` type errors | Wrong type annotation or value |

## Error Recovery

| Error | Action |
|-------|--------|
| `glab` not authenticated | `glab auth login` |
| `GITLAB_TOKEN` missing | Check `GITLAB_NPM_TOKEN` fallback, else set env var |
| Branch not found | `git fetch --all` then retry |
| Push rejected | Resolve conflicts |
| Scripts not found | Fallback to glab CLI commands above |

## Bundled Scripts

### fix-mr-pipeline/scripts/

| Script | Args | Purpose |
|--------|------|---------|
| `check-pipeline-status.js` | `<project_id> <mr_iid>` | Get latest pipeline status for an MR |
| `fetch-pipeline-jobs.js` | `<project_id> <pipeline_id>` | Fetch failed jobs with traces |
| `gitlab-api.js` | — | Shared API client (axios, `PRIVATE-TOKEN` header) |

### autofix-ci-job/scripts/

| Script | Args | Purpose |
|--------|------|---------|
| `check-pipeline-status.js` | `<project_id> <pipeline_id>` | Get pipeline status by pipeline ID |
| `get-pipeline-info.js` | `<project_id> <pipeline_id>` | Full pipeline info incl. failed jobs |
| `fetch-job-logs.js` | `<project_id> <pipeline_id>` | Failed jobs with last 200 lines of trace |
| `fetch-test-report.js` | `<project_id> <pipeline_id>` | Test report with failed test details |
| `gitlab-api.js` | — | Shared API client with validation + helpers |

### review-peer-mrs/scripts/

| Script | Args | Purpose |
|--------|------|---------|
| `mrs-awaiting-review.js` | — (uses `GITLAB_NPM_TOKEN`) | List MRs awaiting your review |


