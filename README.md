# Labelicious 🍩

[![Build Status](https://github.com/hopeman15/labelicious/actions/workflows/main.yml/badge.svg?event=push)](https://github.com/hopeman15/labelicious/actions)
[![codecov](https://codecov.io/github/hopeman15/labelicious/graph/badge.svg?token=Y66XTE8OR8)](https://codecov.io/github/hopeman15/labelicious)
[![License](https://img.shields.io/dub/l/vibe-d.svg)](LICENSE)
[![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-2.1-4baaaa.svg)](CODE_OF_CONDUCT.md)
[![GitHub Marketplace](https://img.shields.io/badge/Marketplace-v0.4.0-undefined.svg?logo=github&logoColor=white&style=flat)](https://github.com/marketplace/actions/labelicious)

Labelicious labels pull requests based on the [Conventional Commits](https://www.conventionalcommits.org/)
type at the start of the PR title.

A keyword matches when the title starts with it and is followed by a scope `(`,
a breaking change `!` or a colon `:`. Matching is case-insensitive. For example,
the keyword `feat` matches all of these titles:

- `feat: add support for arrays`
- `feat(parser): add support for arrays`
- `feat!: drop support for node 16`

It doesn't match `feature: add support` or `chore: quick feat`.

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
        uses: hopeman15/labelicious@0.4.0
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        with:
          keywords: "feat,fix" # optional (see defaults below)
          labels: "feature :moneybag:,bug :bug:" # optional (see defaults below)
```

## Adding Keywords and Labels

You can add keywords and corresponding labels using the **keywords** and **labels**
arguments.

> [!NOTE]
> The keywords and labels arguments are comma-separated lists and must have the
> same length.

### Default Labeling

| Keyword                        | Label                  |
|--------------------------------|------------------------|
| build                          | dependencies :bricks:  |
| chore, refactor, revert, style | housekeeping :broom:   |
| ci                             | CI/CD :cd:             |
| docs                           | documentation :book:   |
| feat                           | feature :moneybag:     |
| fix                            | bug :bug:              |
| perf                           | enhancement :sparkles: |
| test                           | testing :test_tube:    |

## Appending Defaults

You can build upon the default labeling by appending keywords and corresponding
labels using the **append_keywords** and **append_labels** arguments.

```yaml
- uses: hopeman15/labelicious@0.3.0
  with:
    append_keywords: "chore(deps),chore(release)" # optional
    append_labels: "dependencies :bricks:,release :tada:"  # optional
```

> [!NOTE]
> A keyword can include a scope. `chore(deps)` matches `chore(deps): update
> actions/checkout`. That title also matches the default `chore` keyword, so it
> gets both labels.
