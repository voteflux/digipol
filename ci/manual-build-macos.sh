#!/usr/bin/env bash

# based on do-flux-codesign

flutter upgrade \
&& (flutter clean || true) \
&& flutter pub cache repair \
&& flutter build ios --release \
&& cd ios && xcodebuild clean archive -workspace Runner.xcworkspace -scheme Runner -archivePath RunnerArchive && xcodebuild -exportArchive -archivePath RunnerArchive.xcarchive -exportOptionsPlist ExportOptions.plist -exportPath ./build -allowProvisioningUpdates

