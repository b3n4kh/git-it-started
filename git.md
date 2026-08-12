---
title: Git it Started
---

<!-- .slide: class="cover" -->

# Git it Started

### A practical introduction to Git

<p class="muted">© Benjamin Akhras · <a href="https://github.com/b3n4kh/git-it-started">github.com/b3n4kh/git-it-started</a></p>

---

## What Git is for

- Keeping a history of a project
- Comparing versions
- Working on the same code with other people

> Git is a distributed version control system.

---

## The parts that matter

<div class="flow" aria-label="Git workflow">
<span>Working directory</span><b>→</b><span>Index</span><b>→</b><span>Repository</span><b>→</b><span>Remote</span>
</div>

| Where | What it holds | Useful command |
| --- | --- | --- |
| Working directory | Files you are editing | `git status`, `git diff` |
| Index | The next commit | `git add`, `git diff --staged` |
| Repository | Local history | `git log`, `git show` |
| Remote | A shared copy | `git fetch`, `git push` |

---

## Git is local

Git keeps the history in `.git` inside the project directory.

```text
project/
├── README.md       ← project files
└── .git/           ← local Git repository
```

GitHub, GitLab, and a bare repository on a server are remotes. They are useful, but you do not need one to make a commit.

---

## Set your identity once

```bash
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
git config --global init.defaultBranch main
```

Git writes this name and email into every commit you create.

```bash
git config --global --list
```

---

## Get a repository

<div class="two-columns">
<div>

### Start a new project
```bash
mkdir notes
cd notes
git init
```

</div>
<div>

### Get an existing project
```bash
git clone git@github.com:ORG/PROJECT.git
cd PROJECT
```

</div>
</div>

For a project that already exists on GitHub, use `clone`.

---

<!-- .slide: class="section" -->

# Day-to-day work

### status → diff → add → commit

---

## Start with `status`

```bash
git status
```

It shows the current branch, files that changed, files already staged, and whether the local branch is ahead of or behind its remote.

Run it often. It is the quickest way to find out where you are.

---

## Look at the change

```bash
git diff            # changes not staged yet
git diff --staged   # changes in the next commit
```

`git diff` shows lines, not just filenames. Read it before committing.

If it is not clear what a diff does, do not add it yet.

---

## Add what belongs together

```bash
git add README.md
```

`git add` puts the current version of a file into the index. The commit will contain the index, not everything in the working directory.

```bash
git add --patch                 # choose individual changes
git restore --staged README.md  # remove a file from the index
```

---

## Make a commit

```bash
git commit -m "Document local setup"
```

A commit should describe one change that can stand on its own.

<div class="two-columns compact">
<div class="good">✓ Add search validation<br>✓ Fix empty result state<br>✓ Update installation notes</div>
<div class="bad">✗ Changes<br>✗ WIP<br>✗ Fix stuff</div>
</div>

---

## Try the complete loop

```bash
mkdir -p ~/git-playground && cd ~/git-playground
git init
echo "# Git playground" > README.md

git status
git add README.md
git diff --staged
git commit -m "Add readme"
git log --oneline
```

The same loop applies to one file or one hundred files.

---

## Read the history

```bash
git log --oneline --graph --decorate --all
git show HEAD
git show HEAD~1
```

`HEAD` points at the commit currently checked out.

```text
o──o──o  main
      ↑
     HEAD
```

---

<!-- .slide: class="section" -->

# Branches

---

## Work on a branch

```text
o──o──o  main
     \
      o──o  feature/search
```

```bash
git switch -c feature/search
# edit, test, commit
git switch main
```

A branch is a name pointing at a commit. Creating one is cheap; use one before changing shared work.

---

## Bring the work back

```bash
git switch main
git pull --ff-only
git merge --no-ff feature/search
git branch --delete feature/search
```

On a team, this normally happens through a pull request after review and CI.

`git switch` is for branches. `git restore` is for files. The older `git checkout` does both, which is why newer commands are easier to read.

---

## Send a branch for review

```bash
git switch -c feature/search
# edit, test, commit
git push --set-upstream origin feature/search
```

The pull request should answer three things:

1. What changed?
2. Why was it needed?
3. How was it checked?

---

<!-- .slide: class="section" -->

# Working with a remote

---

## Fetch before you pull

```bash
git fetch origin
git log --oneline HEAD..origin/main
git pull --ff-only
git push
```

`fetch` updates your view of the remote without touching your files. Look first, then decide whether to merge, rebase, or pull.

`--ff-only` refuses to create an unexpected merge commit.

---

## A small team workflow

```text
main ────●────────────●────
          \          /
feature ───●──●──●──●
```

1. Create a branch from current `main`.
2. Make small, reviewable commits.
3. Push the branch and open a pull request.
4. Review, test, merge.

---

<!-- .slide: class="section" -->

# When something goes wrong

---

## Changed the wrong file?

```bash
git diff
git restore path/to/file
```

`restore` discards unstaged changes. Read the diff first.

If you want to put work aside without committing it:

```bash
git stash push -m "WIP: checkout investigation"
git stash list
git stash pop
```

---

## Need to fix a commit?

```bash
# The commit is local and not shared yet
git commit --amend

# The commit is already shared
git revert <commit>
```

Amend changes history. Revert adds a new commit that undoes an older one. Do not rewrite a branch other people are using.

---

## Merge conflict

```bash
git status
# resolve the file and test it
git add path/to/file
git commit
```

Git marks the conflicting sections with `<<<<<<<`, `=======`, and `>>>>>>>`.

The hard part is deciding what the file should say. Git only stops and asks you to make that decision.

---

## Keep these close

| Task | Command |
| --- | --- |
| Find out what is going on | `git status` |
| See the actual change | `git diff` |
| Save work | `git add` + `git commit` |
| Start a branch | `git switch -c name` |
| Share commits | `git push` |

The rest is in `git help <command>`.

---

<!-- .slide: class="cover" -->

# Next step

Create a small repository. Make two commits. Create a branch. Push it. Open a pull request.

<p class="callout"><strong>status → diff → add → commit</strong></p>

<p class="muted"><a href="https://github.com/b3n4kh/git-it-started">github.com/b3n4kh/git-it-started</a></p>
