#!/usr/bin/env bash

mark_status(){
    _status="${1:-failure}"
    github-status.py --repo voteflux/voting_app --sha $CI_COMMIT_SHA --status "$_status"
}

mark_status pending

(flutter test && mark_status success) || \
    mark_status failure