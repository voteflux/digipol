set -x
set -e


cd ios
# anything wrong with cocoapods: ideas: "brew {install or upgrade} cocoapods", "cd ios && pod install"
# NOTE: this is actually run by `flutter build ios` (at least with `--release --no-codesign` flags)
# pod install

# If doing a proper release
#flutter build ios --release --codesign --build-name=0.1.2 --build-number "0.1.2"

# Debug build
flutter build ios --debug

# Note:
#   error: No profiles for 'party.flux.digipol' were found: Xcode couldn't find any iOS App Development provisioning profiles matching 'party.flux.digipol'. Automatic signing is disabled and unable to generate a profile. To enable automatic signing, pass -allowProvisioningUpdates to xcodebuild. (in target 'Runner' from project 'Runner')
#   -allowProvisioningUpdates added to below to test

xcodebuild clean archive -workspace Runner.xcworkspace -scheme Runner -archivePath RunnerArchive \
  -allowProvisioningUpdates
xcodebuild -exportArchive -archivePath RunnerArchive.xcarchive -exportOptionsPlist ExportOptions.plist -exportPath ./build -allowProvisioningUpdates \
  -allowProvisioningUpdates
