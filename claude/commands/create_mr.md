---
description: Create Gitlab MR for the current branch
---

# Create Gitlab MR

You are tasked with creating a Gitlab MR for the changes made in the current
branch.

## Process:

1. **Ask the user for the MR title to choose**
   - Look at the commits made in the current branch
   - Run `git log --oneline origin/master..`
   - Please note the base branch is "origin/master" or "origin/qa" or
     "origin/main" depending on the repo.
   - look at the commit titles and decide on 3 options for a title
   - present 3 options to choose from
   - IF there is only one commit.. always use the commit title

5. **Create the MR upon confirmation:**
   - Replace `[title]` with the actual title
   - use `glab mr create -t [title] -d "/assign_reviewer @doxyme/codeowners/platformenablement" --web --push` 


## Important:
- **NEVER add co-author information or Claude attribution**
- Commits should be authored solely by the user
- Do not include any "Generated with Claude" messages
- Do not add "Co-Authored-By" lines
- Write commit messages as if the user wrote them
- Use conventional commit messages. (See @~/.claude/styleguides/conventional_commits.toon)
- Always include JIRA Ticket in the message: e.g. "feat: PE-1234 - Add new feature" 
- If no JIRA ticket add NOJIRA in the message: e.g. "fix(scope): NOJIRA - Fix a bug"

## Remember:
- You have the full context of what was done in this session
- Group related changes together
- Keep commits focused and atomic when possible
- The user trusts your judgment - they asked you to commit
