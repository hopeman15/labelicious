#!/usr/bin/env bash

set -o pipefail

KEYWORDS="${KEYWORDS:-build,chore,ci,docs,feat,fix,perf,refactor,revert,style,test}"
LABELS="${LABELS:-dependencies :bricks:,housekeeping :broom:,CI/CD :cd:,documentation :book:,feature :moneybag:,bug :bug:,enhancement :sparkles:,housekeeping :broom:,housekeeping :broom:,housekeeping :broom:,testing :test_tube:}"

[[ -n "$APPEND_KEYWORDS" ]] && KEYWORDS+=",${APPEND_KEYWORDS}"
[[ -n "$APPEND_LABELS" ]] && LABELS+=",${APPEND_LABELS}"

IFS=',' read -ra keyword_array <<< "$KEYWORDS"
IFS=',' read -ra label_array <<< "$LABELS"

if [[ ${#keyword_array[@]} -ne ${#label_array[@]} ]]; then
    echo "Error: The number of KEYWORDS does not match the number of LABELS."
    exit 1
fi

for i in "${!keyword_array[@]}"; do
    echo "${keyword_array[$i]},${label_array[$i]}"
done
