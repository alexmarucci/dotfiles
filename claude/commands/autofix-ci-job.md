---
name: autofix-ci-job
description: Automatically fix failing GitLab CI jobs by fetching logs, applying fixes, and polling until success
---

# Autofix CI Job

Automatically fix failing GitLab CI jobs. Fetches logs, diagnoses issues, applies fixes locally, commits safely, and polls until pipeline succeeds.

**Usage**: `/autofix-ci-job [md_id|pipeline_id|job_id]`

**Skill**: `autofix-ci-job`

## Workflow

1. **Discovery** - Fetch pipeline info, failed job logs, test reports
2. **Fix** - Apply local fixes based on failure type (tests, types, lint)
3. **Commit** - Safe commit with "fix: NOJIRA - fix pipeline" message
4. **Push** - Only if single commit with that message
5. **Poll** - Check every (last job duration + 20s) until success (max 5 attempts, 1 hour timeout)

## Prerequisites

Load the /fix-mr-pipeline skill first.

## Example

```bash
/autofix-ci-job <gitlab_mr_url> <pipeline_url> <job_url>
```

If no mr, pipeline or ID is given, stop and ask for one.

## Step 1 - Discovery
Fetch pipeline info, failed job logs, test reports using the
/fix-mr-pipeline skill.

If it's a test, fetch the test summary 

Retrieve a test report for a pipeline
`GET /projects/:id/pipelines/:pipeline_id/test_report`

check the logs of that job

## Step 2 - Fix
Use /fix-mr-pipeline to fix the issue and find the root cause

## Step 3 - Commit
Always commit with "fix: NOJIRA - fix pipeline" message

## Step 4 - Push
You are only allowed to commit if if there is a single commit with "fix: NOJIRA - fix pipeline" message.

## Step 5 - Poll
1. Check what time it is first, 
2. Check the last job duration
3. then schedule a crontask with last_job_duration + 1 minute

e.g. if the last failed job duration is 6 minutes, schedule a crontask in 7 minutes 

4. Loop until the job succeeds

/goal The CI job succeeds.

