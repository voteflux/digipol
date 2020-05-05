#!/usr/bin/env bash

source $(dirname "$0")/00-lib.source.sh

mark_status pending "Starting iOS test"

flutter test 2> >(tee tmp.stderr.txt) | tee tmp.stdout.txt

TEST_RES="${PIPESTATUS[0]}"

if [[ "$TEST_RES" == "0" ]]; then
    mark_status success "iOS test success"
else
    mark_status failure "'flutter test' for iOS failed with status: $TEST_RES"
fi

exit "$TEST_RES"
