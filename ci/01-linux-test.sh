#!/usr/bin/env bash

_CIDIR=$(dirname "$0")

source $_CIDIR/00-lib.source.sh

mark_status pending "Starting Android test"

# NOTE: must be on beta channel; we get this for free from the docker container
flutter test --coverage 2> >(tee tmp.stderr.txt) | tee tmp.stdout.txt

TEST_RES="${PIPESTATUS[0]}"

if [[ "$TEST_RES" == "0" ]]; then
    mark_status success "Android test success"
else
    mark_status failure "'flutter test' for Android failed with status: $TEST_RES"
fi

python3 $_CIDIR/lcov_cobertura.py $_CIDIR/../coverage/lcov.info -b $_CIDIR/../ -o $_CIDIR/../coverage/coverage.xml

exit "$TEST_RES"
