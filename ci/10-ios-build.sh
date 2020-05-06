#!/usr/bin/env bash

_CIDIR=$(dirname "$0")

source $_CIDIR/00-lib.source.sh

mark_status "pending" "Beginning iOS build"

IOS_BUILD_EXTRA=${IOS_BUILD_EXTRA:-""}
IOS_EXPORT_EXTRA=${IOS_EXPORT_EXTRA:-""}
export ANDROID_HOME="/Library/Android/sdk"

if [[ "$GITLAB_CI" == "true" ]]; then
  flutter upgrade
  flutter clean || true
  flutter pub cache repair
fi

flutter build ios "$IOS_BUILD_EXTRA"
FLUTTER_BUILD_STATUS="$?"
cd ios
xcodebuild clean archive -workspace Runner.xcworkspace -scheme Runner -archivePath RunnerArchive
XCODE_CLEAN_ARCHIVE_STATUS="$?"
xcodebuild -exportArchive -archivePath RunnerArchive.xcarchive -exportOptionsPlist ExportOptions.plist -exportPath ./build "${IOS_EXPORT_EXTRA}"
XCODE_EXPORT_ARCHIVE_STATUS="$?"

if [[ "$FLUTTER_BUILD_STATUS" != "0" ]] || [[ "$XCODE_CLEAN_ARCHIVE_STATUS" != "0" ]] || [[ "$XCODE_EXPORT_ARCHIVE_STATUS" != "0" ]]; then
  BUILD_STATUS="99"
  mark_status "failure" "iOS build failure"
else
  BUILD_STATUS="0"
  mark_status "success" "iOS build success"
fi

exit "$BUILD_STATUS"
