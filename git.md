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

### git add

```bash
cd ~/git/tutorial
echo "# Git Tutorial" > README.md
git add .
```
↳ Fügt `.` in die staging Area
Note: Es wrid ein temporärer "snapshot" des zustandes erstellt.

---

### git commit

```bash
git commit
```
↳ Persistiert die staging Area
Note: Die "Geschichte" wird weitergeschrieben, --ammend

----

<!-- .slide: data-background-image="static/git3.jpg" data-background-size="contain" -->

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

### git status

```bash
echo -e "\nTest" >> README.md
git status
```
↳ Zeigt aktuellen status

----

### git checkout

```bash
git checkout -- README.md
```
↳ Holt die letzte Version ins working dir.

---

### git branch

```bash
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
git commit --ammend
```
Note: feature branches statt rebase, ammend nur vor push

---

### git remote
```bash
git remote add origin ~/git/tutorial.git
```
↳ Normalerweise ziel auf Server via ssh


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




