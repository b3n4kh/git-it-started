---
title: Git it Started — Deutsch
---

<!-- .slide: class="cover" -->

# Git it Started

### Git ohne Rätsel — Deutsche Ausgabe

<p class="muted">Mit <kbd>→</kbd>, <kbd>Leertaste</kbd> oder Wischen durch den Kurs navigieren.</p>

---

## Nach diesem Kurs kannst du…

<div class="two-columns">
<div>

1. Änderungen prüfen
2. bewusste Zwischenstände sichern
3. einen Feature-Branch erstellen und zusammenführen

</div>
<div>

4. Arbeit sicher mit einem Remote teilen
5. häufige „Hilfe, Git!“-Momente lösen
6. über Pull Requests zusammenarbeiten

</div>
</div>

<p class="callout">Nicht jeden Befehl auswendig lernen: Einen sicheren, wiederholbaren Ablauf aufbauen.</p>

---

## Das mentale Modell

<div class="flow" aria-label="Git-Ablauf">
<span>Arbeitsverzeichnis</span><b>→</b><span>Staging Area</span><b>→</b><span>Commit-Historie</span><b>→</b><span>Remote</span>
</div>

| Ort | Welche Frage beantwortet er? | Befehl |
| --- | --- | --- |
| Arbeitsverzeichnis | Was habe ich geändert? | `git status`, `git diff` |
| Staging Area | Was enthält der nächste Commit? | `git diff --staged` |
| Historie | Was haben wir vorher entschieden? | `git log` |
| Remote | Was hat das Team geteilt? | `git fetch`, `git push` |

---

## Git ist zuerst lokal

Git speichert die Historie im versteckten Verzeichnis `.git`. Du kannst committen, prüfen und Arbeit wiederherstellen – auch ohne Netzwerk.

```text
projekt/
├── README.md        ← deine Dateien
└── .git/            ← Gits lokale Datenbank
```

<p class="callout">Ein Remote wie GitHub ist eine gemeinsame Kopie des Repositories – nicht Git selbst.</p>

---

## Einmalige Einrichtung

Lege eine Identität für deine Commits fest. Verwende deinen Namen und eine verifizierte E-Mail-Adresse.

```bash
git config --global user.name "Ada Lovelace"
git config --global user.email "ada@example.com"

# Sinnvolle Standards für neue Repositories
git config --global init.defaultBranch main
git config --global pull.ff only
```

<p class="muted">Einstellung prüfen: <code>git config --global --get user.name</code>.</p>

---

## Repository anlegen oder kopieren

<div class="two-columns">
<div>

### Neues Projekt
```bash
mkdir recipe-book
cd recipe-book
git init
```

</div>
<div>

### Bestehendes Projekt
```bash
git clone git@github.com:ORG/PROJEKT.git
cd PROJEKT
```

</div>
</div>

<p class="callout">Die tägliche Arbeit beginnt meist mit <code>git clone</code>, nicht mit <code>git init</code>.</p>

---

<!-- .slide: class="section" -->

# Der tägliche Ablauf

### status → diff → add → prüfen → commit

---

## 1. Git nach dem Zustand fragen

```bash
git status
```

Lies die Ausgabe vor jedem Commit. Sie zeigt den aktuellen Branch, veränderte und vorgemerkte Dateien sowie den nächsten sinnvollen Schritt.

```bash
git diff                 # nicht vorgemerkte Änderungen
git diff --staged        # Auswahl für den nächsten Commit
```

<p class="callout">Nie blind committen: Den exakten Patch vorher ansehen.</p>

---

## 2. Bewusst vormerken

```bash
# Eine ganze Datei vormerken
git add README.md

# Oder einzelne Änderungsblöcke auswählen
git add --patch
```

Die Staging Area hält einen Commit bei einer Idee – auch wenn im Arbeitsverzeichnis mehrere Experimente liegen.

```bash
git restore --staged README.md  # Vormerkung entfernen, Änderungen behalten
```

---

## 3. Eine Absicht committen

```bash
git commit -m "Add vegetarian recipe section"
```

Ein guter Commit ist klein, zusammenhängend und erklärt, warum die Änderung existiert. Schreibe die Betreffzeile als Handlung:

<div class="two-columns compact">
<div class="good">✓ Eingaben validieren<br>✓ Lokales Setup dokumentieren<br>✓ Leeren Zustand korrigieren</div>
<div class="bad">✗ Änderungen<br>✗ WIP<br>✗ Dinge repariert</div>
</div>

---

## Übung: erster Zwischenstand

```bash
mkdir -p ~/git-playground && cd ~/git-playground
git init
echo "# Mein Git-Spielplatz" > README.md

git status
git add README.md
git diff --staged
git commit -m "Add project readme"
git log --oneline
```

<p class="callout">Kurz anhalten: Kannst du erklären, wo die README nach jedem Schritt liegt?</p>

---

## Historie als Geschichte lesen

```bash
git log --oneline --graph --decorate --all
git show HEAD
git show HEAD~1
```

`HEAD` bedeutet: „Der aktuell ausgecheckte Commit“. Commits sind unveränderliche Momentaufnahmen, die auf ihre Vorgänger zeigen.

```text
o──o──o  main
      ↑
     HEAD
```

---

<!-- .slide: class="section" -->

# Branches machen Änderungen sicher

---

## Ein Branch ist nur ein beweglicher Name

```text
o──o──o  main
     \
      o──o  feature/search
```

Erstelle einen Branch, bevor du gemeinsamen Code änderst:

```bash
git switch -c feature/search
# Änderungen erstellen und committen
git switch main
```

<p class="callout">Branches sind günstig. Nutze sie, um Arbeit zu isolieren – nicht um Bürokratie zu schaffen.</p>

---

## Ein fertiges Feature zusammenführen

```bash
git switch main
git pull --ff-only
git merge --no-ff feature/search
git branch --delete feature/search
```

Im Team übernimmt ein Pull Request den Merge meist erst nach Review und erfolgreicher CI.

<p class="muted"><code>git switch</code> ist für Branches, <code>git restore</code> für Dateien. Das macht die Absicht klarer als das überladene ältere <code>git checkout</code>.</p>

---

## Über einen Pull Request zusammenarbeiten

```bash
git switch -c feature/search
# bearbeiten, testen, committen
git push --set-upstream origin feature/search
```

Dann einen Pull Request öffnen:

1. Problem und Ansatz erklären
2. Tests, Screenshots oder Issues verlinken
3. Auf Review reagieren
4. CI vor dem Merge abwarten

<p class="callout">Ein Pull Request ist ein Gespräch über eine Änderung – nicht nur ein Knopf vor dem Merge.</p>

---

## Ohne Überraschungen synchronisieren

```bash
git fetch origin                          # Wissen vom Remote laden
git log --oneline HEAD..origin/main       # Neues zuerst ansehen
git pull --ff-only                        # nur ohne automatischen Merge aktualisieren
git push                                  # eigene Commits teilen
```

Nutze `git pull` nicht reflexartig. Prüfe zuerst Branch und uncommittete Arbeit.

---

<!-- .slide: class="section" -->

# Wiederherstellen: langsam werden, prüfen, wählen

---

## „Ich habe die falsche Datei geändert“

```bash
git diff
git restore pfad/zur/datei    # nicht vorgemerkte Änderungen einer Datei verwerfen
```

`restore` erst nach dem Diff benutzen. Falls die Arbeit wichtig werden könnte, zuerst sichern:

```bash
git stash push -m "WIP: Checkout-Ablauf untersuchen"
git stash list
git stash pop
```

<p class="callout">Git kann viel wiederherstellen. Absichtlich verworfene Änderungen nur dann, wenn sie vorher committet oder gestasht wurden.</p>

---

## „Mein letzter Commit braucht eine Korrektur“

```bash
# Noch nicht geteilt: bearbeiten, vormerken, dann ergänzen
git commit --amend

# Bereits geteilt: einen neuen Gegen-Commit erstellen
git revert <commit>
```

<div class="two-columns compact">
<div class="good">✓ Privates ergänzen<br>✓ Öffentliches revertieren</div>
<div class="bad">✗ Geteilte Branches force-pushen<br>✗ Historie umschreiben, von der andere abhängen</div>
</div>

---

## „Es gibt einen Merge-Konflikt“

1. Konfliktdatei lesen und das gewünschte Ergebnis wählen.
2. Konfliktmarker entfernen: `<<<<<<<`, `=======`, `>>>>>>>`.
3. Ergebnis testen und vormerken.
4. Vorgang fortsetzen.

```bash
git status
# auflösen und testen
git add pfad/zur/aufgeloesten-datei
git commit                 # bei Merge
# oder: git rebase --continue
```

<p class="muted">Ein Konflikt ist kein Git-Fehler. Git bittet einen Menschen, zwischen zwei gültigen Änderungen zu entscheiden.</p>

---

## Die fünf Befehle zum Merken

| Bedarf | Befehl |
| --- | --- |
| Orientierung | `git status` |
| Änderung ansehen | `git diff` |
| Änderung sichern | `git add` + `git commit` |
| Isoliert starten | `git switch -c feature/name` |
| Teilen | `git push` |

Alles andere ist mit `git help <command>` schnell auffindbar.

---

<!-- .slide: class="cover" -->

# Deine nächsten 15 Minuten

1. Repository erstellen und zwei fokussierte Commits anlegen.
2. Einen `feature/readme`-Branch erstellen und eine Sache ändern.
3. Zu GitHub pushen und einen Pull Request öffnen.
4. Den finalen Patch vor dem Merge prüfen.

<p class="callout">Die Gewohnheit aufbauen: <strong>status → diff → add → prüfen → commit</strong>.</p>

<p class="muted">Quellcode und Updates: <a href="https://github.com/b3n4kh/git-it-started">github.com/b3n4kh/git-it-started</a></p>
