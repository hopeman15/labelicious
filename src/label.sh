#!/usr/bin/env bash

set -o pipefail

GITHUB_TOKEN="${GITHUB_TOKEN:?GITHUB_TOKEN is not set}"
PR_NUMBER="${PR_NUMBER:?PR_NUMBER is not set}"
REPO="${REPO:?REPO is not set}"

KEYWORDS="${KEYWORDS:-Bug,CI/CD,Dependencies,Dependency,Documentation,Enhancement,Feature,Fix,Housekeeping,Refactoring,Release,Testing}"
LABELS="${LABELS:-bug :bug:,CI/CD :cd:,dependencies,dependencies,documentation :book:,enhancement :sparkles:,feature :moneybag:,bug :bug:,housekeeping :broom:,housekeeping :broom:,release :tada:,testing :test_tube:}"

PR_TITLE=$(gh pr view "$PR_NUMBER" -R "$REPO" --json title -q '.title')

add_label() {
    local label="$1"
    local keyword="$2"
    if [[ "$PR_TITLE" == *"$keyword"* ]]; then
        echo "Adding label: $label for keyword: $keyword"
        gh pr edit "$PR_NUMBER" --add-label "$label" -R "$REPO"
    fi
}

# Convert KEYWORDS and LABELS into arrays
IFS=',' read -ra keyword_array <<< "$KEYWORDS"
IFS=',' read -ra label_array <<< "$LABELS"

# Ensure KEYWORDS and LABELS arrays have the same length
if [[ ${#keyword_array[@]} -ne ${#label_array[@]} ]]; then
    echo "Error: The number of KEYWORDS does not match the number of LABELS."
    exit 1
fi

# Apply labels based on keywords
for i in "${!keyword_array[@]}"; do
    keyword="${keyword_array[$i]}"
    label="${label_array[$i]}"
    add_label "$label" "$keyword"
done

echo "Labeling completed."
