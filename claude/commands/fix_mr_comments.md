---
description: Fixes MR comments by fetching, analysing, and creating actionable plans for each comment
---

# Fix MR Comments Workflow

## Step 1: Get MR Details
Ask user for the MR ID if not provided in the command:
- If no MR ID: "Please provide the GitLab MR ID you want me to analyse"
- If provided: Continue with the given ID

## Step 2: Fetch and Filter Comments
Execute the following command to fetch human comments (excluding bots and system notes):

```bash
glab mr view {MR_ID} --unresolved -F json | jq '[.Discussions[] | .notes[] | select(
    ((.author.username // "" | test("bot"; "i") | not) or (.author.email // "" | length > 0)) and
    (.system // false | not) and
    (.type | IN("DiffNote", "DiscussionNote"))
  )]' > {MR_ID}_comments.json
```

## Step 3: Analyse Comments
Read the comments file and create a comprehensive analysis: {MR_ID}_comments.json

For each comment, extract:
- Comment ID and URL
- Author information
- Comment body/content
- File location (if applicable)
- Suggested actions needed

## Step 4: Create Action Plan
Generate a structured plan using TodoWrite for each comment requiring action:

For Comment 1 (by [Author], about [Topic]):
- [ ] Analyse issue mentioned in the comment
- [ ] Implement necessary changes in file:line
- [ ] Verify fix addresses the concern
- [ ] Add/update tests if needed

For Comment 2 (by [Author], about [Topic]):
- [ ] ...

## Step 5: Get Confirmation
Present the complete plan to the user:
"I've analysed {X} comments from the MR. Here's my action plan:

[Display the complete todo list]

Would you like me to proceed with implementing these changes?"


## Step 6: Implement the Changes
Only after confirmation, use superpowers:receiving-code-review skill for implementing
the changes. 

Use team agents. If the user confirmed, only then Spawn teammates for each comment. 
use the general-purpose agent with the superpowers:receiving-code-review skill for implementing the tasks. 
Each agent is responsible for one Comment only.

Keep a maximum of 2 agents in parallel, wait for their completion before
continuing.

## Notes:
- NEVER commit or push changes or comments to the MR
- Skip comments that are:
  - Acknowledgements ("Thanks!", "LGTM")
  - Questions already answered
  - Duplicate issues
  - Outdated/superseded comments
- Prioritise:
  1. Blocking issues that prevent merge
  2. Code quality and security concerns
  3. Documentation and comment improvements
  4. Minor stylistic suggestions
