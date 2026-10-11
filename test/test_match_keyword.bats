#!/usr/bin/env bats

load test_helper.bash

@test "Validate match on type followed by a colon" {
    run match_keyword.sh "feat: add support for arrays" "feat"

    assert_success
}

@test "Validate match on type followed by a scope" {
    run match_keyword.sh "fix(parser): handle empty input" "fix"

    assert_success
}

@test "Validate match on type followed by a breaking change" {
    run match_keyword.sh "feat!: drop node 16" "feat"

    assert_success
}

@test "Validate match on keyword including a scope" {
    run match_keyword.sh "chore(deps): update actions/checkout" "chore(deps)"

    assert_success
}

@test "Validate match is case-insensitive" {
    run match_keyword.sh "FEAT: Add Support" "feat"

    assert_success
}

@test "Validate no match when keyword is not at the start of the title" {
    run match_keyword.sh "chore: quick fix for the readme" "fix"

    assert_failure
}

@test "Validate no match when keyword is only a prefix of the type" {
    run match_keyword.sh "feature: add support" "feat"

    assert_failure
}

@test "Validate no match when keyword is not followed by a type delimiter" {
    run match_keyword.sh "test the labeler" "test"

    assert_failure
}

@test "Validate no match on an empty keyword" {
    run match_keyword.sh "feat: add support" ""

    assert_failure
}
