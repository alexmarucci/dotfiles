
description: Create a worktree to work on a ticket
---

description: Create worktree and launch implementation session for a plan
---

1. ask the use for JIRA ticket number and branch name. Use this information in
   the next step

2. set up worktree for implementation:
2a. read `~/.claude/hack/create_worktree.sh`  to understand the requirements

3. determine required data:

branch name
JIRA ticket name
path to plan file (use relative path only)

3a. confirm with the user by sending a message 

4. create a new worktree with the JIRA branch name by running this script: `~/.claude/hack/create_worktree.sh PE-XXXX BRANCH_NAME`
