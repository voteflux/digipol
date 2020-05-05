#!/usr/bin/env bash

if [[ "$GITLAB_CI" == "true" ]] && [[ "$CI_BUILD_ID" != "" ]]; then
    STATUS_SCRIPT_URL="https://gist.githubusercontent.com/XertroV/ed38440cb694382852e8dae01c9daed2/raw/ba9b9b326076c375b23365a7cac87b275fea211f/github-status.py"
    mkdir ~/bin
    curl "$STATUS_SCRIPT_URL" > ~/bin/github-status
    chmod +x ~/bin/github-status
    export PATH="$HOME/bin:$PATH"
fi

source $(dirname "$0")/00-lib.source.sh

mark_status pending "Starting Android test"

flutter test 2> >(tee tmp.stderr.txt) | tee tmp.stdout.txt

TEST_RES="${PIPESTATUS[0]}"

if [[ "$TEST_RES" == "0" ]]; then
    mark_status success "Android test success"
else
    mark_status failure "Android test failed with status: $TEST_RES"
fi

exit "$TEST_RES"
