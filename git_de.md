---
title: Git it Started
---

<!-- .slide: class="cover" -->

# Git it Started

### Ein kompakter Einstieg in Git

<p class="muted">© Benjamin Akhras · <a href="https://github.com/b3n4kh/git-it-started">github.com/b3n4kh/git-it-started</a></p>

---

## Wofür Git da ist

- Änderungen nachvollziehen
- Alte Stände vergleichen und wiederherstellen
- Gemeinsam an einem Projekt arbeiten

> Git ist eine verteilte Versionsverwaltung.

---

## Die vier Bereiche

<div class="flow" aria-label="Git-Ablauf">
<span>Arbeitsverzeichnis</span><b>→</b><span>Index</span><b>→</b><span>Repository</span><b>→</b><span>Remote</span>
</div>

| Bereich | Inhalt | Nützliche Befehle |
| --- | --- | --- |
| Arbeitsverzeichnis | Dateien, an denen du arbeitest | `git status`, `git diff` |
| Index | Inhalt des nächsten Commits | `git add`, `git diff --staged` |
| Repository | Lokale Historie | `git log`, `git show` |
| Remote | Gemeinsame Kopie | `git fetch`, `git push` |

---

## Git arbeitet lokal

Die Historie liegt im Verzeichnis `.git` direkt im Projekt.

```text
projekt/
├── README.md       ← Projektdateien
└── .git/           ← lokales Git-Repository
```

GitHub, GitLab oder ein Bare Repository auf einem Server sind Remotes. Praktisch für die Zusammenarbeit, aber für einen Commit nicht nötig.

---

## Name und E-Mail hinterlegen

```bash
git config --global user.name "Dein Name"
git config --global user.email "du@example.com"
git config --global init.defaultBranch main
```

Git trägt diese Angaben in jeden Commit ein.

```bash
git config --global --list
```

---

## Ein Repository bekommen

<div class="two-columns">
<div>

### Neues Projekt
```bash
mkdir notizen
cd notizen
git init
```

</div>
<div>

### Vorhandenes Projekt
```bash
git clone git@github.com:ORG/PROJEKT.git
cd PROJEKT
```

</div>
</div>

Ein Projekt, das schon auf GitHub liegt, klonst du mit `git clone`.

---

<!-- .slide: class="section" -->

# Die tägliche Arbeit

### status → diff → add → commit

---

## Erst einmal: `status`

```bash
git status
```

Zeigt den aktuellen Branch, geänderte Dateien, vorgemerkte Dateien und den Stand zum Remote.

`git status` ist der Befehl, den du am häufigsten brauchst. Wenn etwas unklar ist: zuerst `status`.

---

## Änderungen ansehen

```bash
git diff            # noch nicht vorgemerkte Änderungen
git diff --staged   # Inhalt des nächsten Commits
```

`git diff` zeigt Zeilen, nicht nur Dateinamen. Vor dem Commit anschauen.

Wenn der Diff nicht klar ist, gehört die Änderung noch nicht in den Commit.

---

## Zusammengehöriges vormerken

```bash
git add README.md
```

`git add` schreibt den aktuellen Stand einer Datei in den Index. Der Commit enthält den Index, nicht automatisch alles im Arbeitsverzeichnis.

```bash
git add --patch                 # einzelne Änderungen auswählen
git restore --staged README.md  # aus dem Index nehmen
```

---

## Commit erstellen

```bash
git commit -m "Lokales Setup dokumentieren"
```

Ein Commit sollte eine nachvollziehbare Änderung enthalten.

<div class="two-columns compact">
<div class="good">✓ Eingabe prüfen<br>✓ Leere Trefferliste korrigieren<br>✓ Installationshinweise ergänzen</div>
<div class="bad">✗ Änderungen<br>✗ WIP<br>✗ Kram gefixt</div>
</div>

---

## Einmal komplett durchspielen

```bash
mkdir -p ~/git-spielplatz && cd ~/git-spielplatz
git init
echo "# Git-Spielplatz" > README.md

git status
git add README.md
git diff --staged
git commit -m "Readme anlegen"
git log --oneline
```

Der Ablauf bleibt derselbe, egal ob eine Datei oder hundert geändert wurden.

---

## In die Historie schauen

```bash
git log --oneline --graph --decorate --all
git show HEAD
git show HEAD~1
```

`HEAD` zeigt auf den Commit, den du gerade ausgecheckt hast.

```text
o──o──o  main
      ↑
     HEAD
```

---

<!-- .slide: class="section" -->

# Mit Branches arbeiten

---

## Für Änderungen einen Branch anlegen

```text
o──o──o  main
     \
      o──o  feature/search
```

```bash
git switch -c feature/search
# bearbeiten, testen, committen
git switch main
```

Ein Branch ist ein Name, der auf einen Commit zeigt. Einen anzulegen kostet nichts; für Änderungen an gemeinsamem Code lohnt es sich fast immer.

---

## Änderungen zurückführen

```bash
git switch main
git pull --ff-only
git merge --no-ff feature/search
git branch --delete feature/search
```

Im Team passiert das üblicherweise über einen Pull Request – nach Review und erfolgreicher CI.

`git switch` ist zum Branch wechseln, `git restore` für Dateien. Das ältere `git checkout` kann beides und ist deshalb weniger eindeutig.

---

## Einen Branch zur Prüfung schicken

```bash
git switch -c feature/search
# bearbeiten, testen, committen
git push --set-upstream origin feature/search
```

Ein Pull Request sollte drei Fragen beantworten:

1. Was wurde geändert?
2. Warum ist die Änderung nötig?
3. Wie wurde sie geprüft?

---

<!-- .slide: class="section" -->

# Mit einem Remote arbeiten

---

## Erst fetchen, dann pullen

```bash
git fetch origin
git log --oneline HEAD..origin/main
git pull --ff-only
git push
```

`fetch` holt Informationen vom Remote, ohne deine Dateien anzufassen. Erst ansehen, dann entscheiden: mergen, rebasen oder pullen.

`--ff-only` verhindert einen Merge-Commit, den du nicht erwartet hast.

---

## Ein einfacher Team-Ablauf

```text
main ────●────────────●────
          \          /
feature ───●──●──●──●
```

1. Branch von aktuellem `main` anlegen.
2. Kleine, prüfbare Commits machen.
3. Branch pushen und Pull Request öffnen.
4. Review, Tests, Merge.

---

<!-- .slide: class="section" -->

# Wenn etwas schiefgeht

---

## Falsche Datei geändert?

```bash
git diff
git restore pfad/zur/datei
```

`restore` verwirft nicht vorgemerkte Änderungen. Deshalb vorher den Diff lesen.

Arbeit kurz weglegen, ohne sie zu committen:

```bash
git stash push -m "WIP: Checkout untersuchen"
git stash list
git stash pop
```

---

## Ein Commit muss korrigiert werden?

```bash
# Noch nicht geteilt
git commit --amend

# Bereits geteilt
git revert <commit>
```

`amend` schreibt Historie um. `revert` erstellt einen neuen Commit, der einen alten rückgängig macht. Geteilte Branches nicht umschreiben.

---

## Merge-Konflikt

```bash
git status
# Datei auflösen und testen
git add pfad/zur/datei
git commit
```

Git markiert die betroffenen Stellen mit `<<<<<<<`, `=======` und `>>>>>>>`.

Der Konflikt liegt im Inhalt, nicht in Git: Entscheide, wie die Datei danach aussehen soll.

---

## Diese Befehle reichen für den Anfang

| Aufgabe | Befehl |
| --- | --- |
| Orientierung | `git status` |
| Änderung ansehen | `git diff` |
| Arbeit sichern | `git add` + `git commit` |
| Branch anlegen | `git switch -c name` |
| Commits teilen | `git push` |

Für den Rest: `git help <command>`.

---

<!-- .slide: class="cover" -->

# Und jetzt

Ein kleines Repository anlegen. Zwei Commits machen. Einen Branch erstellen. Pushen. Pull Request öffnen.

<p class="callout"><strong>status → diff → add → commit</strong></p>

<p class="muted"><a href="https://github.com/b3n4kh/git-it-started">github.com/b3n4kh/git-it-started</a></p>
