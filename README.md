# voting_app

--------------------------------------------------------------------------------

# DigiPol - Parliament of the People

## Description

### Primary Program Objectives

The DigiPol Voting App (temporary name for now) will allow Australian Voters to be able to vote on current _issues_ and _bills_ within the political landscape.

- **Bills** will be the legislation proposals put forth in Parliament, worded as is.
- **Issues** will be generated according to public interest and contemporary topics as they arise.

It will collate voting results and show users the results of their electorates voting on bills. It will allow them to send an automatically generated email to their elected representative, as well as post the results out onto various social media.

### Sample

![image](/assets/graphics/sample.gif)

### Pages & Components - App Alpha

- **Issues Page** - list of issues generated, sortable by date, popularity, controversiality(?)
- **Bills Page** - list of bills sortable by house, date, progress
- **Voting Page** - full description/links and voting buttons
- **Login Page** - email - password
- **Results Page** - list of horizontal bar graphs - 1 for each electorate
- **Verification/Settings Page** - AEC details, electorate details, representatives and voting patterns, join Flux button, link Settingss (google/fb/ig)

### Program Protocols

The UI/UX is based on the [Flutter Framework](https://flutter.dev/) that uses the Dart Programming Language (this repo). The majority of development is in the `lib` directory which contains:

- `main.dart` - Where the app starts (BottomNavBar here)
- `route_generator.dart` - where all the page routing is done
- `styles.dart` - where the colour themes are set
- `custom_widgets.dart` - where the shared widgets are kept
- `voting_widgt.dart` - where the voting widget + states are
- `/lib/api` directory for the API interaction code.
- `/assets` directory for the assets (images, media, data).
- The rest contain the different pages of the app (hopefully naming is good enough to guide you)

Edit `pubspec.yaml` to include other packages.

#### Outside this repo:

- Databases and API are managed on AWS using lambda functions Data for Bills are mirrored from the federal and state parliament websites using the [ausbills](https://github.com/KipCrossing/Aus-Bills) python package
- Issues are manually entered into the database for now
- New Issues/Bills and votes are recorded on the block-chain

--------------------------------------------------------------------------------

## Contributing

A list of current items and their progress can be found [here](https://github.com/voteflux/voting_app/projects/1). If you feel comfortable diving straight in, just fork the repo, and open it up in Android Studio. We use [Effective Dart](https://dart.dev/guides/language/effective-dart) to guide our coding style, so make sure you make yourself familiar. Make the contributions you want to and create a Pull Request.

For collaborating, best practice is to join our _Discord Community_ at [discord.io / FluxParty](discord.io/FluxParty) and let us know where you're interested in helping out. That way we can make sure you are up to date with all the relevant information and put you in contact with others working on the project!

If you are new to Flutter here are a few resources to get you started on your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)
- [online documentation](https://flutter.dev/docs), which offers tutorials, samples, guidance on mobile development, and a full API reference.

### Getting started

Install dependencies:

```
sudo apt install curl
```

Get flutter:

```
git clone https://github.com/flutter/flutter.git -b master
echo '#Add Flutter to PATH' >> $HOME/.bashrc
echo 'export PATH="$PATH:'$(pwd)'/flutter/bin"' >> $HOME/.bashrc
source $HOME/.bashrc
echo "Check the flutter is in path"
echo $PATH
flutter precache
echo "Check your dependencies:"
flutter doctor
```

Download and install [Android Studio](https://developer.android.com/studio) and install the Flutter plugin:

Run `flutter doctor` again to check dependencies.

#### For web dev:

```
flutter channel beta
flutter upgrade
flutter config --enable-web
```

Make sure you have Chrome installed

```
flutter devices
```

And Run `flutter run -d chrome` in the project dir.

--------------------------------------------------------------------------------

## Future Plans (Beta)

- Graphs (Public Voice)
- Commenting on Bills
- Weekly Reports
- Politi Compass - Personalised Voting History
- Create Issues UI
- User Settingss
- Settings - Notifications, Emails
- sorting bills - Date, title, chamber
- Search bar
- results map

----------

## Architecture Overview

![High level overview of the voting app system](docs/images/voting-app-system.png)

<!-- can't put  mermaid.js code straight in an HTML comment because
it uses the closing tag in its syntax. And can't display:none it apparently :/
so we'll just include it all for the moment. Figure out something better later -->

### about this chart

The flowchart was generated with mermaid.js

See: https://mermaid-js.github.io/mermaid/#/flowchart and https://github.com/mermaid-js/mermaid

Live editor: https://mermaid-js.github.io/mermaid-live-editor/

current source code:

```mermaid
graph BT

subgraph External Internet
PH(APH or WAPH website)
end

subgraph Queue
BillQ(New Bill Queue)
end

subgraph "User (App)"
App(App/Main UI component)
KeyStore(Key Store component)
end

subgraph "Optional User Environment"
UserNode(Optional user-run full node)
UserAuditor(Optional user-run auditor)
end

subgraph Bill Tracking Environment
BillTracker(Bill Tracking Service)
BillDB("Bill Database<br/>(results can be in different DB)")
BillApi(Bill info API)
ResultsCacheApi(Results Cache API)
AuditJob("Auditor, scheduled (Purescript/JS)")
end

subgraph Blockchain Env
BillToBallot(Bill to Ballot handler)
BallotArchive(Ballot Archive)
PrivChain(Private Eth Instance)
end

PH -->|scraped| BillTracker
BillTracker -.-|stores state| BillDB
BillTracker -->|push to Q| BillQ
BillDB -.->|info served| BillApi

AuditJob -.->|store results on<br/>issue close| BillDB
BillDB -.->|serve results| ResultsCacheApi

BillQ -->|retrived by| BillToBallot
BillToBallot -->|pushes ballotspec| BallotArchive
BillToBallot -->|creates issue on chain| PrivChain

BillApi -->|General info,<br/>ammendments, etc| App 
ResultsCacheApi -->|Cached results served| App 
PrivChain -->|Democracy inst. and<br/>issue index data| App
App -.-|Signing votes| KeyStore
App -->|Push signed votes| PrivChain
App -.->|Alt: push signed votes| UserNode

UserNode -.-|sync| PrivChain
UserNode -->|raw votes| UserAuditor
```
