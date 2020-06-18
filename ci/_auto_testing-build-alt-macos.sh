set -x
set -e

#flutter build ios --release --codesign --build-name=0.1.2 --build-number "0.1.2"

cd ios
# anything wrong with cocoapods: ideas: "brew {install or upgrade} cocoapods", "cd ios && pod install"
pod install

xcodebuild clean archive -workspace Runner.xcworkspace -scheme Runner -archivePath RunnerArchive
xcodebuild -exportArchive -archivePath RunnerArchive.xcarchive -exportOptionsPlist ExportOptions.plist -exportPath ./build -allowProvisioningUpdates
