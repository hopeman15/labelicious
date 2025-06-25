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
    assert_output --partial "Bug,bug :bug:"
    assert_output --partial "CI/CD,CI/CD :cd:"
    assert_output --partial "Dependencies,dependencies :bricks:"
    assert_output --partial "Dependency,dependencies :bricks:"
    assert_output --partial "Documentation,documentation :book:"
    assert_output --partial "Enhancement,enhancement :sparkles:"
    assert_output --partial "Feature,feature :moneybag:"
    assert_output --partial "Fix,bug :bug:"
    assert_output --partial "Housekeeping,housekeeping :broom:"
    assert_output --partial "Refactoring,housekeeping :broom:"
    assert_output --partial "Release,release :tada:"
    assert_output --partial "Testing,testing :test_tube:"
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
    assert_output --partial "Bug,bug :bug:"
    assert_output --partial "CI/CD,CI/CD :cd:"
    assert_output --partial "Dependencies,dependencies :bricks:"
    assert_output --partial "Dependency,dependencies :bricks:"
    assert_output --partial "Documentation,documentation :book:"
    assert_output --partial "Enhancement,enhancement :sparkles:"
    assert_output --partial "Feature,feature :moneybag:"
    assert_output --partial "Fix,bug :bug:"
    assert_output --partial "Housekeeping,housekeeping :broom:"
    assert_output --partial "Refactoring,housekeeping :broom:"
    assert_output --partial "Release,release :tada:"
    assert_output --partial "Testing,testing :test_tube:"
    assert_output --partial "keyword-1,label-1"
    assert_output --partial "keyword-2,label-2"
}
