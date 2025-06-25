# Labelicious 🍩

[![Build Status](https://github.com/hopeman15/labelicious/actions/workflows/main.yml/badge.svg?event=push)](https://github.com/hopeman15/labelicious/actions)
[![codecov](https://codecov.io/github/hopeman15/labelicious/graph/badge.svg?token=Y66XTE8OR8)](https://codecov.io/github/hopeman15/labelicious)
[![License](https://img.shields.io/dub/l/vibe-d.svg)](LICENSE)
[![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-2.1-4baaaa.svg)](CODE_OF_CONDUCT.md)

Labelicious labels pull requests based on keywords found in the PR title.

## Usage

```yaml
name: Label 🏷️

on:
  pull_request:
    types: [ synchronize, opened, reopened ]

jobs:
  label:
    name: Label
    runs-on: ubuntu-latest
    permissions:
      pull-requests: write
    steps:
      - name: Labeling
        uses: hopeman15/labelicious@0.2.2
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        with:
          keywords: "Movie,Documentary" # optional (see defaults below)
          labels: "movie :popcorn:,documentary :movie_camera:" # optional (see defaults below)
```

## Adding Keywords and Labels

You can add keywords and corresponding labels using the **keywords** and **labels**
arguments.

> [!NOTE]
> The keywords and labels arguments are comma-separated lists and must have the
> same length.

### Default Labeling

| Keyword                   | Label                  |
|---------------------------|------------------------|
| Bug, Fix                  | bug :bug:              |
| CI/CD                     | CI/CD :cd:             |
| Dependency, Dependencies  | dependencies :bricks:  |
| Documentation             | documentation :book:   |
| Enhancement               | enhancement :sparkles: |
| Feature                   | feature :moneybag:     |
| Housekeeping, Refactoring | housekeeping :broom:   |
| Release                   | release :tada:         |
| Testing                   | testing :test_tube:    |

## Appending Defaults

You can build upon the default labeling by appending keywords and corresponding
labels using the **append_keywords** and **append_labels** arguments.

```yaml
- uses: hopeman15/labelicious@0.2.2
  with:
    append_keywords: "Movie,Documentary" # optional
    append_labels: "movie :popcorn:,documentary :movie_camera:"  # optional
```
