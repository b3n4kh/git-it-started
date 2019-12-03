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

> A the stupid content tracker

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
Note: Nachlesen wenn gebraucht

----

```bash
man 1 git
man 7 giteveryday
man 7 gittutorial
```
Note: Nachlesen wenn gebraucht

---

# Tutorial
Note: Bash öffnen / git installiern

---

### git config

```bash
git config --global user.name  "Benjamin Akhras"
git config --global user.email "b@akhras.at"
```
Note: Auf jeder Maschine 1x global

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
↳ Zeigt aktuellen status

---

### git add

```bash
cd ~/git/tutorial
echo "# Git Tutorial" > README.md
git add .
```
↳ Fügt `.` in die staging Area
Note: Es wrid ein temporärer "snapshot" des zustandes erstellt.

----

<!-- .slide: data-background-image="static/git_lc.png" data-background-size="contain" -->

---

### git commit

```bash
git commit
```
↳ Persistiert die staging Area
Note: Die "Geschichte" wird weitergeschrieben, --amend

----

<!-- .slide: data-background-image="static/git3.jpg" data-background-size="contain" -->

----

<!-- .slide: data-background-image="static/git_lc.png" data-background-size="contain" -->

---

### git diff

```bash
git diff [--cached]
```
↳ Zeigt die Änderungen seit commit
Note: Wenn schon gestagted dann mit --cached

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
↳ Holt die letzte Version ins working dir.

----

<!-- .slide: data-background-image="static/git_lc.png" data-background-size="contain" -->

---

### git branch

```aaabash
git branch devel
```
↳ Erstellt den branch "devel"  
Note: Wie in allen VCS, feature-branches, 

----

```bash
git branch
```
↳  __lokale__ zeiger auf den aktuellen branch
Note: * zeigt auf HEAD

----

<!-- .slide: data-background-image="static/checkout-master.png" data-background-size="contain" -->

---

### git checkout

```bash
git checkout devel
```
↳ Wechselt in den branch "devel"  

----

```bash
git checkout -b devel master
```
↳ Erstellt und wechselt in den branch "devel"  
Note: Quell branch aus dem erstellt wird

----

<!-- .slide: data-background-image="static/git_lc.png" data-background-size="contain" -->

---

### recap

| Command  | Action                  |
|----------|--------------------------|
| add      | Neue Datein aufnehmen    |
| commit   | Staging persistieren     |
| checkout | Update working dir       |

----

<span style="color:red">⚠ History umschreiben ist gefährlich ⚠</span>

```bash
git rebase
git commit --amend
```
Note: feature branches statt rebase, amend nur vor push

----

<!-- .slide: data-background-image="static/git_history.jpg" data-background-size="contain" -->

---

### git remote
```bash
git remote add origin ~/git/tutorial.git
```
↳ Normalerweise ziel auf Server via ssh

----

<!-- .slide: data-background-image="static/git_workflow.png" data-background-size="contain" -->

----

### git push
```bash
git push -u origin master
```
↳ Publiziert änderungen an das remote
Note: Erst jetzt für andere verfügbar, jetzt kein history rewrite mehr

----

### git clone
```bash
git clone ~/git/tutorial.git ~/git/tutorial-clon
```
↳ Erstellt lokale Kopie

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
↳ Kein History rewrite in devel sondern neuer Branch
Note: Richtiges Feature abgrenzen ist schwierig

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

