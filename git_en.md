---
title: git it started
---

# Git

© Benjamin Akhras

https://git.akhras.at/  
https://github.com/b3n4kh/git-it-started

---

## Was ist Git

----

* Versionsverwaltung
* Kollaboration
* GitOps

> Git - the stupid content tracker

---

> Git is a fast, scalable, distributed revision control system with an unusually rich command set that provides both high-level operations and full access to internals.

----

<!-- .slide: data-background-image="static/git_lc.png" data-background-size="contain" -->

---

<!-- .slide: data-background-image="static/git1.jpg" data-background-size="contain" -->
Note: Ziel der Folien

---

### Memorize

`add, commit, checkout, status, pull and push`

---

### Look up when needed

`clone, init, config, log, diff`

----

```bash
man 1 git
man 7 giteveryday
man 7 gittutorial
```
Note: Read up when needed

---

# Tutorial
Note: Bash öffnen / git installiern

---

### git config

```bash
git config --global user.name  "Benjamin Akhras"
git config --global user.email "b@akhras.at"
```
Note: On every machine => use dotfiles management

---

### git init

```bash
mkdir -p ~/git
git init ~/git/tutorial
```
↳ erzeugt `.git` verzeichnis
Note: Siehe in VSCode

----

### git init --bare

```bash
git init --bare ~/git/tutorial.git
```
↳ Kein `.git` verzeichnis
↳ Hilft bei Kollaboration
Note: Working VS Sharing, $name.git

---

### git status

```bash
echo -e "\nTest" >> README.md
git status
```
↳ show current state

---

### git add

```bash
cd ~/git/tutorial
echo "# Git Tutorial" > README.md
git add .
```
↳ Add `.` into staging Area
Note: This creates a temporary "snapshot" of the current state.

----

<!-- .slide: data-background-image="static/git_lc.png" data-background-size="contain" -->

---

### git commit

```bash
git commit
```
↳ persist the staging area
Note: A new entry is added to the "History"

----

<!-- .slide: data-background-image="static/git3.jpg" data-background-size="contain" -->

----

<!-- .slide: data-background-image="static/git_lc.png" data-background-size="contain" -->

---

### git diff

```bash
git diff [--cached]
```
↳ show changes since last commit
Note: If already staged show with `--cached`

----

### git log

```bash
git log
```
↳ Zeigt die "history" des Repository
Note: `git log --stat --summary`

---

### git checkout

```bash
git checkout -- README.md
```
↳ Gets last version into working directory.

----

<!-- .slide: data-background-image="static/git_lc.png" data-background-size="contain" -->

---

### git branch

```aaabash
git branch devel
```
↳ create branch "devel"

----

```bash
git branch
```
↳  __lokale__ shows current branch
Note: * points to HEAD

----

<!-- .slide: data-background-image="static/checkout-master.png" data-background-size="contain" -->

---

### git checkout

```bash
git checkout devel
```
↳ switch to branch "devel"  

----

```bash
git checkout -b devel master
```
↳ create and switch to "devel"  
Note: <source_branch> <new_branch> 

----

<!-- .slide: data-background-image="static/git_lc.png" data-background-size="contain" -->

---

### recap

| Command  | Action                   |
|----------|--------------------------|
| add      | add new file or folder   |
| commit   | persist stageging        |
| checkout | update working dir       |

----

<span style="color:red">⚠ rewriting history is dangerous ⚠</span>

```bash
git rebase
git commit --amend
```
Note: feature branches instead of rebase, amend only before push

----

<!-- .slide: data-background-image="static/git_history.jpg" data-background-size="contain" -->

---

### git remote
```bash
git remote add origin ~/git/tutorial.git
```
↳ usually target is on a remote server via ssh

----

<!-- .slide: data-background-image="static/git_workflow.png" data-background-size="contain" -->

----

### git push
```bash
git push -u origin master
```
↳ publish changes to the remote
Note: Now available for others, from now on don't rewrite history

---

<!-- .slide: data-background-image="static/git_push.jpg" data-background-size="contain" -->

----

### git clone
```bash
git clone ~/git/tutorial.git ~/git/tutorial-clon
```
↳ create local copy

----

### git pull
```bash
git pull
```
↳ Holt änderungen von dem getrackten remote  

----

<!-- .slide: data-background-image="static/git_workflow.png" data-background-size="contain" -->

---

### Playground

```bash
cd ~/git/tutorial
git remote add origin ~/git/tutorial.git
echo -e "\nMit Remote" >> README.md
git commit -am "added remote"
git push -u origin master
cd ~/git/tutorial-clon
git pull
```

### Breaking Stuff

```bash
git checkout -B devel && echo -e "\nA" >> README.md && git commit -am "A"
git push -u origin devel
cd ~/git/tutorial-clon
git checkout -B devel && echo -e "\nB" >> README.md && git commit -am "B"
git push -u origin devel
git pull
```

---

### Feature Branches

```bash
git checkout -B featureA master
git merge --squash devel
```
↳ No History rewrite in devel but new branch
Note: Proper feature separation is difficult

----

### Always Branch away from master

This avoids conflicts, and is easier and clearer to review and merge.

----

<!-- .slide: data-background-image="static/merge.png" data-background-size="contain" -->

---

### Test 

Code quality can be improved by testing it.  
Multiple "lines of defense":

0. Lint
1. Test
2. Code Review
3. Continues Integration

----

<!-- .slide: data-background-image="static/test.jpg" data-background-size="contain" -->

---

### Important Concepts

<div style="text-align: left;">
<p><span style="color:red">Problem:</span>
We never know the state</p>
<p><span style="color:green">Solution:</span>
Idempotentcy</p>
</div>

----

<div style="text-align: left;">
<p><span style="color:red">Problem:</span>
Dependencies change</p>
<p><span style="color:green">Solution:</span>
Automate</p>
</div>

----

<div style="text-align: left;">
<p><span style="color:red">Problem:</span>
Releases are to fast to test</p>
<p><span style="color:green">Solution:</span>
Automate</p>
</div>

----

<!-- .slide: data-background-image="static/devops.png" data-background-size="contain" -->

---

### DevOps

> DevOps is a philosophy, not a method, or framework, or body of knowledge

----

> DevOps is the philosophy of unifying Development and Operations at the culture, practice, and tool levels, to achieve accelerated and more frequent deployment of changes to Production

----

<!-- .slide: data-background-image="static/devops.png" data-background-size="contain" -->

---

|Concept|→|Tool|
|---|---|---|
|Code|→|Git|
|Build|→|Gitlab-CI|
|Test|→|CI|
|Package|→|RPM|
|Release|→|Foreman|
|Configure|→|Puppet|
|Monitor|→|Icinga|

