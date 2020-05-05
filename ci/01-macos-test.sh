#!/usr/bin/env bash

mark_status(){
    _status="${1:-failure}"
    _msg="${2:-No message provided :(}"
    if [[ "$GITLAB_CI" == "true" ]] && [[ "$CI_BUILD_ID" != "" ]]; then
        github-status --repo voteflux/voting_app --sha "$CI_COMMIT_SHA" --status "$_status" --desc "$_msg"
    else
        echo "[DEBUG] setting github status for voteflux/voting_app (sha: ${CI_COMMIT_SHA}) to $_status: $_msg" 1>&2
    fi
}

mark_status pending "Starting Macos test"

flutter test 2> >(tee tmp.stderr.txt) | tee tmp.stdout.txt

TEST_RES="${PIPESTATUS[0]}"

if [[ "$TEST_RES" == "0" ]]; then
    mark_status success "Macos test success"
else
    mark_status failure "Failed with status; $TEST_RES"
fi

exit "$TEST_RES"
