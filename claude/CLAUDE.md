# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code.

Be extremely concise. Sacrifise grammar and punctuation for the sake of clarity and conciseness.

Before scheduling any CronTask, cron jobs, or scheduled task, or anything time
related, always check the local time: Bash(date '+%H:%M %d/%m/%Y') 

## General Rules and Preferences

Style guide files for different languages to follow: 
- @~/.claude/styleguides/typescript-style-guide.toon

### Language and Spelling
- Always use British English spelling (e.g., "colour", "centre", "analyse", "organise", "licence", "defence")
- Use "-ise" endings instead of "-ize" (e.g., "organise", "realise", "apologise")
- Use "-our" endings instead of "-or" (e.g., "colour", "favour", "honour")
- Use "-re" endings instead of "-er" (e.g., "centre", "metre", "theatre")
- Date format: DD/MM/YYYY (e.g., 16/12/2025)
- Time format: 12-hour clock (e.g., 2:30 PM, not 14:30)

### Code Documentation
- Write clear, concise comments that explain the "why" not the "what"
- Use present tense in comments (e.g., "Validates the input" not "Will validate")
- Keep line comments to the right of code when brief, otherwise place above
- TODO comments should include action items and context: `// TODO: Add input validation for edge cases`

### Error Messages and Logging
- Write user-facing error messages in clear, simple language
- Use consistent error message format: "[Action] failed: [Reason]"
- Log levels: ERROR for failures, WARN for deprecation, INFO for important events, DEBUG for troubleshooting
- Include correlation IDs in all log entries for traceability

### Naming Conventions
- Use descriptive names that indicate purpose
- Avoid abbreviations unless widely understood (e.g., "id", "url", "api")
- Function names should be verbs: `getUserById()`, `validateInput()`
- Variable names should be nouns: `user`, `isValid`, `responseData`
- Boolean variables should start with "is", "has", "can", "should": `isActive`, `hasPermission`

### File and Directory Naming
- Use camelCase for file and directory names: `userService.ts`, `apiConfig/`
- Keep file names short but descriptive
- Group related files in appropriate directories

### Code Organisation
- Order imports: external libraries first, then internal modules, then relative imports
- Group related functionality together
- Keep functions focused on a single responsibility
- Prefer composition over inheritance
- Use dependency injection for better testability

### Testing Guidelines
- Always use present tense: "it("validates input" not "it("should validate input"

### Repository Pattern Analysis
Before making any code changes to the codebase, always use @codebase-pattern-finder
to search for existing patterns.
The goal is to keep the codebase consistent with its existing style and patterns, even if they differ from general best practices
This approach ensures the repository remains cohesive and maintainable by respecting the established code culture and patterns already in place.

### Creating Repository-Specific Style Guides

When working in a new repository or when you are making code
changes, search for patterns before implementation:

1. **TODO** - Do I know this pattern already? If I already know the
   pattern to use, then I stop here and make the changes. Otherwise,
   continue to the next step
2. **If a pattern is already documented and you can confirm it's being followed** - Do not search for it again
3. **Search for patterns not in the global guide** - Search in the
   codebase for patterns related to the changes you are making.
4. **Add only repository-specific findings** - Include patterns, conventions, and practices unique to this repository
6. Write append your finding to the style-guide.md file in the repo .claude folder. `.claude/style-guide.md`

Abstract Example:

Task: You need to write a line that "some code"
Procedure:
- Do I know which pattern we use for "some code"?
- if YES, I implement using that pattern
- if NO, I search for "some code" patterns in the codebase
- then, I add the pattern to the style-guide.md file in the repo .claude folder
- finally, I implement the changes using the pattern just discovered

Concrete Example:

Task: You need to write a line that interpolates string
Procedure:
- Do I know which pattern we use to interpolate strings?
- if YES, I implement using that pattern
- if NO, I search for string interpolation patterns in the codebase
- then, I add the pattern to the style-guide.md file in the repo .claude folder
- finally, I implement the changes using the pattern just discovered

### Recommendation
- "Glob tool needs path and pattern separate: use Glob(path='.claude', pattern='*'), not Glob(pattern='.claude//')"*

### Browser Harness
- @/Users/alessio/projects/hacks/browser-harness/SKILL.md (Direct browser control via CDP. Use when the user wants to automate, scrape, test, or interact with web pages. Connects to the user's already-running Chrome);
