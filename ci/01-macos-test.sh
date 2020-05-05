#!/usr/bin/env bash



mark_status(){
    _status="${1:-failure}"
    if [[ "$GITLAB_CI" == "true" ]] && [[ "$CI_BUILD_ID" != "" ]]; then
        github-status.py --repo voteflux/voting_app --sha $CI_COMMIT_SHA --status "$_status"
    fi
}

mark_status pending

(flutter test && mark_status success) || \
    mark_status failure