#!/usr/bin/env bash

# if [[ "$GITLAB_CI" == "true" ]] && [[ "$CI_BUILD_ID" != "" ]]; then
#     alias github-status="$(dirname $0)/github-status.py"
# fi

if ! (python3 -c 'import requests'); then
  python3 -m pip install --user requests
fi

echo "ci directory: $(dirname $0)"
echo "$0"

mark_status(){
    _status="${1:-failure}"
    _msg="${2:-No message provided :(}"
    if [[ "$GITLAB_CI" == "true" ]] && [[ "$CI_BUILD_ID" != "" ]]; then
        "$(dirname $0)/github-status.py" --repo voteflux/voting_app --sha "$CI_COMMIT_SHA" --status "$_status" --desc "$_msg"
    else
        echo "[DEBUG] setting github status for voteflux/voting_app (sha: ${CI_COMMIT_SHA}) to $_status: $_msg" 1>&2
    fi
}
