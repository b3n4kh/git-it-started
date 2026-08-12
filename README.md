# Git it Started

A short course covering Git basics: commits, branches, remotes, pull requests, and recovery. It is available in English and German.

The published course is available at [b3n4kh.github.io/git-it-started](https://b3n4kh.github.io/git-it-started/): [English](https://b3n4kh.github.io/git-it-started/en/) and [Deutsch](https://b3n4kh.github.io/git-it-started/de/).

## What learners practice

- The everyday loop: `status → diff → add → review → commit`
- Feature branches and pull requests
- Safe syncing with `fetch`, `pull --ff-only`, and `push`
- Recovery with `restore`, `stash`, `amend`, and `revert`

## Run locally

This project uses Node.js 20.19–22 and npm.

```bash
npm ci
npm start
```

Open the local URL printed by reveal-md. It serves the English deck; the build exports both languages. Press <kbd>Space</kbd> or <kbd>→</kbd> to advance.

## Build and verify

```bash
npm test
```

This exports a language-selection page and both decks to `_site/`, then checks their HTML and course assets.

## Deploy

Pushing to `master` runs the GitHub Actions workflow. Pull requests build and smoke-test the course; only pushes to `master` upload and deploy the Pages artifact. In the repository’s **Settings → Pages**, choose **GitHub Actions** as the publishing source once. The deployment URL is recorded in the workflow’s `github-pages` environment.

## License and attribution

This repository is licensed under the BEER-WARE LICENSE. Existing images in `static/` retain their original attribution; see the source history for their provenance.
