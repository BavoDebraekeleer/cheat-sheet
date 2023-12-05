# Git

## Commit

### Commit Messages

[9 Best Practices for Writing Good Git Commit Messages by Kirinyet Brian](https://www.linkedin.com/pulse/7-best-practices-writing-good-git-commitmessages-kirinyet-brian/)
[How to Write Better Git Commit Messages – A Step-By-Step Guide by Natalie Pina](https://www.freecodecamp.org/news/how-to-write-better-git-commit-messages/)
[Best Practices for Naming Git Branches](https://tilburgsciencehub.com/building-blocks/collaborate-and-share-your-work/use-github/naming-git-branches/)

Best Practices:
1. Be Clear and Concise
2. Include Relevant Context
3. Mention Bug Fixes
4. Organize Commits logically
5. Use Imperative Verbs
6. Summarize with a Subject Line
7. Test and Proofread
8. Follow a Template
9. Update Commit Messages

#### 1. Be Clear and Concise

 A good commit message should be clear and concise, summarizing the changes made in the commit. Avoid vague or generic messages like “Fixed a bug” or “Updated code.” Instead, provide specific details that describe the purpose or impact of the changes.

#### 2. Include Relevant Context

 It’s essential to include relevant context in your commit messages. Mention any relevant issue numbers, feature requests, or discussions related to the changes. This helps others understand the motivation behind the commit and facilitates collaboration.

#### 3. Mention Bug Fixes

 If your commit addresses a bug or issue, make sure to reference it in the commit message. Include a brief description of the problem and how your changes fix it. This helps track the resolution of bugs and improves the overall project understanding.

#### 4. Organize Commits logically

If you’re working on a larger feature or fixing multiple issues, consider breaking your changes into smaller, logical commits. Each commit should represent a self-contained unit of work that makes sense on its own. This makes it easier to review, revert, or cherry-pick specific commits.

#### 5. Use Imperative Verbs

Write commit messages in the imperative mood. Start with a verb that describes what the commit does, such as “Add,” “Fix,” “Update,” or “Refactor.” This helps convey the purpose of the commit and makes the messages more actionable.

#### 6. Summarize with a Subject Line

Begin your commit message with a brief subject line (around 50 characters) that summarizes the main purpose of the commit. This subject line is what will be displayed in various commit logs, so make it meaningful and informative.

#### 7. Test and Proofread

Before committing your changes, double-check them for errors and test them thoroughly. Ensure that your changes adhere to the project’s coding standards and conventions. Additionally, proofread your commit message to ensure it is free from typos or grammatical errors.

#### 8. Follow a Template

Establish a commit message template for your team or project to maintain consistency. This could include sections like "Summary," "Description," "Testing," or "References." Templates help standardize commit messages and provide a structure for information.

#### 9. Update Commit Messages

If you need to update a commit message, use Git's --amend option instead of adding a new commit. This avoids cluttering the commit history with multiple messages and ensures that the commit remains self-contained.

#### Commit Type

The commit type can include the following:

- `feat` – a new feature is introduced with the changes
- `fix` – a bug fix has occurred
- `chore` – changes that do not relate to a fix or feature and don't modify src or test files (for example updating dependencies)
- `refactor` – refactored code that neither fixes a bug nor adds a feature
- `docs` – updates to documentation such as a the README or other markdown files
- `style` – changes that do not affect the meaning of the code, likely related to code formatting such as white-space, missing semi-colons, and so on.
- `test` – including new or correcting previous tests
- `perf` – performance improvements
- `ci` – continuous integration related
- `build` – changes that affect the build system or external dependencies
- `revert` – reverts a previous commit

#### Examples

- `Add margin to nav items to prevent them from overlapping the logo`
- `feat: improve performance with lazy load implementation for images`
- `chore: update npm dependency to latest version`
- `Fix bug preventing users from submitting the subscribe form`
- `Update incorrect client phone number within footer body per client request`


## Branches

### Switch Branches

- *Default*: switches from current branch to specified branch. If there are uncommited changes to the current branch changing won't be allowed.
- `-f`, `--force`, or `--discard-changes`: let's you discard any uncommited changes to the current branch before switching.
- `-m`: triggers a three-way merge between the current branch, your working tree contents, and the new branch: you won't lose your work in progress that way.

```git
git switch <branch-name>

git switch -f <branch-name> // --force or --discard-changes on current branch.

git switch -m <branch-name> // Merges current branch, including changes, with specified branch.
```