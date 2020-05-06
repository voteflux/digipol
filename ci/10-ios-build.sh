#!/usr/bin/env bash

_CIDIR="$(dirname \"$0\")"

source "$_CIDIR/00-lib.source.sh"

mark_status "pending" "Beginning iOS build"

do-flux-codesign

BUILD_STATUS="$?"

if [[ "$BUILD_STATUS" == "0" ]]; then
    mark_status "success" "iOS build success"
else
    mark_status "failure" "iOS build failure"
fi

exit "$BUILD_STATUS"
