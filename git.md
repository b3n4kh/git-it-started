# Git

© Benjamin Akhras

https://akhras.at/git/

---

## Was ist Git

----

* Versionsverwaltung
* Kollaboration
* GitOps
Note: A the stupid content tracker

----

<!-- .slide: data-background-image="static/git_lc.png" data-background-size="contain" -->

---


<!-- .slide: data-background-image="static/git1.jpg" data-background-size="contain" -->
Note: Ziel der Folien

---

### Memorize

`clone, pull, checkout, status, commit and push`

---

### Look up when needed

`init, config, log`
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
mkdir -p ~/git/tutorial
git init ~/git/tutorial
```
↳ erzeugt `.git` verzeichnis
Note: Siehe in VSCode

----

### git init --bare

```bash
mkdir -p ~/git/tutorial.git
git init --bare ~/git/tutorial.git
```
↳ Kein `.git` verzeichnis
↳ Hilft bei Kollaboration
Note: Working VS Sharing, $name.git

---

### git init

```bash
mkdir -p ~/git/tutorial.git
git init --bare ~/git/tutorial.git
```
↳ erzeugt `.git` verzeichnis
Note: Auf jeder Maschine 1x global