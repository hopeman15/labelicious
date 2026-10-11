#!/usr/bin/env bats
#
# variable changes will be discarded. all tests run in subshells.
# shellcheck disable=SC2030
# shellcheck disable=SC2031
#

load test_helper.bash

@test "Validate KEYWORDS and LABELS defaults" {
    run parse_labels.sh

    assert_success
    assert_output --partial "build,dependencies :bricks:"
    assert_output --partial "chore,housekeeping :broom:"
    assert_output --partial "ci,CI/CD :cd:"
    assert_output --partial "docs,documentation :book:"
    assert_output --partial "feat,feature :moneybag:"
    assert_output --partial "fix,bug :bug:"
    assert_output --partial "perf,enhancement :sparkles:"
    assert_output --partial "refactor,housekeeping :broom:"
    assert_output --partial "revert,housekeeping :broom:"
    assert_output --partial "style,housekeeping :broom:"
    assert_output --partial "test,testing :test_tube:"
}

@test "Validate error when the number of KEYWORDS and LABELS differ" {
    export KEYWORDS="keyword-1,keyword-2"
    export LABELS="label-1"

    run parse_labels.sh

    assert_failure
    assert_output "Error: The number of KEYWORDS does not match the number of LABELS."
}

@test "Validate correct output when the number of KEYWORDS and LABELS match" {
    export KEYWORDS="keyword-1,keyword-2"
    export LABELS="label-1,label-2"

    run parse_labels.sh

    assert_success
    assert_output --partial "keyword-1,label-1"
    assert_output --partial "keyword-2,label-2"
}

@test "Validate KEYWORDS and LABELS are amended" {
    export APPEND_KEYWORDS="keyword-1,keyword-2"
    export APPEND_LABELS="label-1,label-2"

    run parse_labels.sh

    assert_success
    assert_output --partial "build,dependencies :bricks:"
    assert_output --partial "chore,housekeeping :broom:"
    assert_output --partial "ci,CI/CD :cd:"
    assert_output --partial "docs,documentation :book:"
    assert_output --partial "feat,feature :moneybag:"
    assert_output --partial "fix,bug :bug:"
    assert_output --partial "perf,enhancement :sparkles:"
    assert_output --partial "refactor,housekeeping :broom:"
    assert_output --partial "revert,housekeeping :broom:"
    assert_output --partial "style,housekeeping :broom:"
    assert_output --partial "test,testing :test_tube:"
    assert_output --partial "keyword-1,label-1"
    assert_output --partial "keyword-2,label-2"
}
