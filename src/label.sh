#!/usr/bin/env bash

set -o pipefail

GITHUB_TOKEN="${GITHUB_TOKEN:?GITHUB_TOKEN is not set}"
PR_NUMBER="${PR_NUMBER:?PR_NUMBER is not set}"
REPO="${REPO:?REPO is not set}"

PR_TITLE=$(gh pr view "$PR_NUMBER" -R "$REPO" --json title -q '.title')

"${GITHUB_ACTION_PATH}/src/parse_labels.sh" | while IFS=',' read -r keyword label; do
  if [[ "$PR_TITLE" == *"$keyword"* ]]; then
    echo "Adding label: $label for keyword: $keyword"
    gh pr edit "$PR_NUMBER" --add-label "$label" -R "$REPO"
  fi
done

echo "Labeling completed."
