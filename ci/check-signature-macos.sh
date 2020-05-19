#!/usr/bin/env bash

echo "This is currently broken, but there are working not-eacy-to-script methods in this file, come have a look"

# doesn't seem to work
codesign -dv --verbose=4 $@

# if we can pull embedded.mobileprovision out of the app: (ipa is just a zip, inside is the "Payload" folder)
#> security cms -D -i /Users/xertrov/src/voting_app/ios/build/Payload/Runner.app/embedded.mobileprovision

# previwing that file in finder sorta works too

exit 0

the `ipa` tool via `gem install shenzhen` is soooo nice by comparison...

~/src/voting_app add-manual-helper-scripts +2 !3 ?4 ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────── ✘ INT 12:10:29
❯ ipa info ios/build/Runner.ipa
+-----------------------------+----------------------------------------------------------+
| AppIDName                   | DigiPol Test App                                         |
| ApplicationIdentifierPrefix | 25DYQ99XVS                                               |
| CreationDate                | 2020-05-06T01:23:49+00:00                                |
| Platform                    | iOS                                                      |
| IsXcodeManaged              | true                                                     |
| Entitlements                | application-identifier: 25DYQ99XVS.party.flux.digipol    |
|                             | keychain-access-groups: ["25DYQ99XVS.*"]                 |
|                             | get-task-allow: false                                    |
|                             | com.apple.developer.team-identifier: 25DYQ99XVS          |
|                             | aps-environment: production                              |
| ExpirationDate              | 2021-05-04T06:59:34+00:00                                |
| Name                        | iOS Team Ad Hoc Provisioning Profile: party.flux.digipol |
| ProvisionedDevices          | 00008020-00034C360A04002E                                |
| TeamIdentifier              | 25DYQ99XVS                                               |
| TeamName                    | The Flux Foundation Limited                              |
| TimeToLive                  | 363                                                      |
| UUID                        | 148ea66c-dd91-4bc7-813c-521737d09064                     |
| Version                     | 1                                                        |
| Codesigned                  | True                                                     |
+-----------------------------+----------------------------------------------------------+
