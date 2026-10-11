#!/usr/bin/env bash
#
# Usage: match_keyword.sh <title> <keyword>
#
# Succeeds when the title starts with the keyword as a conventional commit
# type, i.e. the keyword is followed by a scope "(", a breaking change "!" or ":".
#

set -o pipefail

TITLE="${1,,}"
KEYWORD="${2,,}"

[[ -n "$KEYWORD" && "$TITLE" == "$KEYWORD"[\(\!:]* ]]
