---
title: Git it Started — English
---

<!-- .slide: class="cover" -->

# Git it Started

### Git, without the mystery — English edition

<p class="muted">Use <kbd>→</kbd>, <kbd>Space</kbd>, or a swipe to move through the course.</p>

---

## By the end, you can…

<div class="two-columns">

<div>

1. inspect what changed
2. save deliberate checkpoints
3. create and merge a feature branch

</div>
<div>

4. share work safely with a remote
5. resolve the common “help, Git!” moments
6. collaborate through a pull request

</div>
</div>

<p class="callout">The goal is not to memorize every command. It is to build a safe, repeatable loop.</p>

---

## The mental model

<div class="flow" aria-label="Git workflow">

<span>Working tree</span><b>→</b><span>Staging area</span><b>→</b><span>Commit history</span><b>→</b><span>Remote</span>

</div>

| Place | Question it answers | Command |
| --- | --- | --- |
| Working tree | What have I changed? | `git status`, `git diff` |
| Staging area | What will my next commit contain? | `git diff --staged` |
| History | What did we decide before? | `git log` |
| Remote | What did the team share? | `git fetch`, `git push` |

---

## Git is local first

Git records history in a hidden `.git` directory. You can commit, inspect, and recover work without a network connection.

```text
project/
├── README.md        ← your files
└── .git/            ← Git’s local database
```

<p class="callout">A remote such as GitHub is a shared copy of the repository—not Git itself.</p>

---

## One-time setup

Set an identity for the commits you create. Use your own name and a verified email address.

```bash
git config --global user.name "Ada Lovelace"
git config --global user.email "ada@example.com"

# Helpful defaults for new repositories
git config --global init.defaultBranch main
git config --global pull.ff only
```

<p class="muted">Check a setting with <code>git config --global --get user.name</code>.</p>

---

## Start or copy a repository

<div class="two-columns">

<div>

### New project

```bash
mkdir recipe-book
cd recipe-book
git init
```

</div>
<div>

### Existing project

```bash
git clone git@github.com:ORG/PROJECT.git
cd PROJECT
```

</div>
</div>

<p class="callout">Most day-to-day work starts with <code>git clone</code>, not <code>git init</code>.</p>

---

<!-- .slide: class="section" -->

# The everyday loop

### status → diff → add → review → commit

---

## 1. Ask Git what it sees

```bash
git status
```

Read it before every commit. It tells you the current branch, changed files, staged files, and the next sensible action.

```bash
git diff                 # unstaged changes
git diff --staged        # changes selected for the next commit
```

<p class="callout">Never commit blind: review the exact patch that will be saved.</p>

---

## 2. Stage deliberately

```bash
# Stage a whole file
git add README.md

# Or select individual hunks interactively
git add --patch
```

The staging area lets one commit contain one idea—even when your working tree contains several experiments.

```bash
git restore --staged README.md  # unstage; keep your edits
```

---

## 3. Commit an intention

```bash
git commit -m "Add vegetarian recipe section"
```

A good commit is small, coherent, and describes why the change exists. Write the subject as an imperative action:

<div class="two-columns compact">

<div class="good">✓ Add input validation<br>✓ Document local setup<br>✓ Fix empty-state layout</div>
<div class="bad">✗ Changes<br>✗ WIP<br>✗ Fix stuff</div>

</div>

---

## Practice: make your first checkpoint

```bash
mkdir -p ~/git-playground && cd ~/git-playground
git init
echo "# My Git playground" > README.md

git status
git add README.md
git diff --staged
git commit -m "Add project readme"
git log --oneline
```

<p class="callout">Pause here. Can you explain where the README lives at every step?</p>

---

## Read history like a story

```bash
git log --oneline --graph --decorate --all
git show HEAD
git show HEAD~1
```

`HEAD` means “the commit currently checked out.” Commits are immutable snapshots linked to their parent.

```text
o──o──o  main
      ↑
     HEAD
```

---

<!-- .slide: class="section" -->

# Branches make change safe

---

## A branch is just a movable name

```text
o──o──o  main
     \
      o──o  feature/search
```

Create a branch before changing shared code:

```bash
git switch -c feature/search
# make and commit your changes
git switch main
```

<p class="callout">Branches are cheap. Use them to isolate work, not to create ceremony.</p>

---

## Merge a completed feature

```bash
git switch main
git pull --ff-only
git merge --no-ff feature/search
git branch --delete feature/search
```

In a team, a pull request usually performs the merge after review and CI pass.

<p class="muted">Use <code>git switch</code> for branches and <code>git restore</code> for files. They make intent clearer than the overloaded legacy <code>git checkout</code>.</p>

---

## Collaborate through a pull request

```bash
git switch -c feature/search
# edit, test, commit
git push --set-upstream origin feature/search
```

Then open a pull request:

1. explain the problem and the approach
2. link tests, screenshots, or relevant issues
3. respond to review
4. let CI pass before merging

<p class="callout">The pull request is a conversation around a change—not merely a button before merge.</p>

---

## Sync without surprises

```bash
git fetch origin                          # download remote knowledge
git log --oneline HEAD..origin/main       # inspect what is new
git pull --ff-only                        # update only when no merge is needed
git push                                  # share your commits
```

Avoid using `git pull` as a reflex. First know which branch you are on and whether you have uncommitted work.

---

<!-- .slide: class="section" -->

# Recovery: slow down, inspect, choose

---

## “I changed the wrong file”

```bash
git diff
git restore path/to/file        # discard unstaged edits to one file
```

Only run `restore` after reading the diff. If the work may matter, preserve it first:

```bash
git stash push -m "WIP: investigate checkout flow"
git stash list
git stash pop
```

<p class="callout">Git is good at recovery. It cannot recover a change you intentionally discard unless it was committed or stashed.</p>

---

## “My last commit needs fixing”

```bash
# Not shared yet: edit, stage, then amend
git commit --amend

# Already shared: make a new corrective commit
git revert <commit>
```

<div class="two-columns compact">
<div class="good">✓ Amend private work<br>✓ Revert public work</div>
<div class="bad">✗ Force-push shared branches<br>✗ Rewrite history people depend on</div>
</div>

---

## “There is a merge conflict”

1. Read the conflicting file and choose the intended result.
2. Remove the conflict markers: `<<<<<<<`, `=======`, `>>>>>>>`.
3. Test the result, then stage it.
4. Continue the operation.

```bash
git status
# resolve and test
git add path/to/resolved-file
git commit                 # merge
# or: git rebase --continue
```

<p class="muted">A conflict is not a Git failure. It is Git asking a human to decide between two valid edits.</p>

---

## The five commands worth memorizing

| Need | Command |
| --- | --- |
| Orient yourself | `git status` |
| Inspect a change | `git diff` |
| Save a change | `git add` + `git commit` |
| Start isolated work | `git switch -c feature/name` |
| Share it | `git push` |

Everything else is searchable with `git help <command>`.

---

<!-- .slide: class="cover" -->

# Your next 15 minutes

1. Create a repository and make two focused commits.
2. Create a `feature/readme` branch and change one thing.
3. Push it to GitHub and open a pull request.
4. Review the final patch before merging.

<p class="callout">Build the habit: <strong>status → diff → add → review → commit</strong>.</p>

<p class="muted">Course source and updates: <a href="https://github.com/b3n4kh/git-it-started">github.com/b3n4kh/git-it-started</a></p>
