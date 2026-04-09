---
name: fix-mr-pipeline
description: Fix a failed GitLab pipeline for a given MR
---

Fix a failed GitLab CI pipeline for an MR. Works in the current working directory — assumes correct repo and branch.

Usage: `/fix-mr-pipeline <MR_IID>`

Use the `fix-mr-pipeline` skill. Pass the MR IID as the argument.

If no IID provided, ask the user which MR to fix.
