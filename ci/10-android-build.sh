#!/usr/bin/env bash

_CIDIR=$(dirname "$0")

source $_CIDIR/00-lib.source.sh

mark_status "pending" "Android build starting"

flutter build apk --debug

BUILD_STATUS="$?"

if [[ "$BUILD_STATUS" == "0" ]]; then
    mark_status "success" "Android build success"
else
    mark_status "failure" "Android build failure"
fi

exit "$BUILD_STATUS"
