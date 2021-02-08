# DigiPol

## *Connecting Real People with their Parliament*

--------------------------------------------------------------------------------

## Primary Program Objectives

The DigiPol Voting App will allow Australian Voters to be able to vote on current _issues_ and _bills_ within the political landscape.


### Sample

![image](/assets/graphics/sample.gif)

## Contributing

Join us on

[![image](/assets/graphics/discord.png)](https://discord.gg/xFMUTZw) <!-- .element height="50%" width="50%" -->

A list of current items and their progress can be found in the project boards. If you feel comfortable diving straight in, just fork the repo, and open it up in Android Studio.

We use [Effective Dart](https://dart.dev/guides/language/effective-dart) to guide our coding style, so make sure you make yourself familiar. Make the contributions you want to and create a Pull Request.

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

Get flutter (copy in all lines, run from home the location you want to install flutter):

```
git clone https://github.com/flutter/flutter.git -b stable && \
echo '#Add Flutter to PATH' >> $HOME/.bashrc && \
echo 'export PATH="$PATH:'$(pwd)'/flutter/bin"' >> $HOME/.bashrc && \
export PATH="$PATH:$(pwd)/flutter/bin" && \
echo "Check the flutter is in path" && \
echo $PATH && \
flutter precache && \
echo "Check your dependencies:" && \
flutter doctor
```

Download and install [Android Studio](https://developer.android.com/studio) and install the Flutter plugin:

Run `flutter doctor` again to check dependencies.

## BUILD INSTRUCTIONS

* You **must** run `flutter pub run build_runner build --delete-conflicting-outputs` to generate necessary files.
  * You **should** probably have `flutter pub run build_runner watch --delete-conflicting-outputs` running while you develop
    * You **should** use the scripts (or contribute new scripts) in `./tool/` instead of coming back to the readme to find the commands.
* `flutter pub get` for dependencies (make sure to use the newest stable version of flutter possible)
* `flutter run` to run -- or just use the debug button in android-studio / vs-code.

---

# The App Architecture

## Front end

The app frontend is built with [Flutter](https://flutter.dev/) using the Dart Programming Language. This repo will focus entirely on this part of the project.

## Back end

- The app backend is built using multiple serverless lambdas to interact with MongoDB and other external services. **(NOTE: This repo will only cover the UI Architecture, for information on the backend head over to [voting-app-api](https://github.com/KipCrossing/voting-app-api)**
- Databases and API are managed on AWS using lambda functions Data for Bills are mirrored from the federal and state parliament websites using the [ausbills](https://github.com/KipCrossing/Aus-Bills) python package
- The app will utilise the Ethereum blockchain to validate votes.
- Issues are manually entered into the database for now

# Flutter Architecture

_This section assumes you have basic understanding of Flutter. If you are new to Flutter see the bottom of the repo for resources_.

The app uses a [Provider](https://flutter.dev/docs/development/data-and-backend/state-mgmt/simple) Architecture for state management. It is structured so data flows to only the views that need it. _The apps structure was inspired by this [Filledstacks](https://www.filledstacks.com/post/flutter-architecture-my-provider-implementation-guide/) guide. If you are new to flutter and plan on contributing we highly recommend you check out this tutorial._

The idea behind the directory architecture is to abstract the logic away from the UI. This allows for more maintainable code and extensibility. Simply as is sounds, any app logic goes into the Core any UI goes into the UI.

**High level Architecture Points**

- Each view will have it's own model that extends the ChangeNotifier.
- Notify listeners for a view will ONLY BE CALLED when the View's state changes.
- Each view only has 2 states. Idle and Busy. Any other piece of UI contained in a view, that requires logic and state / UI updates will have it's own model associated with it. This way the main view only paints when the main view state changes.
- Providers will NOT be passed in through app level global provider, unless it's required by more than 1 view in the app architecture (Users information).
- Models will ONLY request data from Services and reduce state from that DATA. Nothing else.

**hivedb, API interaction & local storage**
- The app uses [Hivedb](https://github.com/hivedb/hive) to store the API, blockchain data and user preferences locally. This allows for faster app performance & cheaper API hosting costs. If you are planning on contributing to the core, you must read the Hive docs to understand how it works.
- On startup the app calls the API and blockchain endpoints and stores the data in Hive models with custom adaptors ([read here](https://docs.hivedb.dev/#/custom-objects/generate_adapter)).
- All static data in the UI is called from Hive and not from API directly.
- Total votes is still called directly on the models currently

--------------------------------------------------------------------------------

## Core

All app logic is contained in this directory.

- **models** - Contains all the data models
- **services** - Contains the dedicated files that will handle actual app logic
- **viewmodels** - Contains the Provider models for each of the Widget views
- **enums** - Storing any reusable enums

## UI

Any UI element or styling feature is contained here. Avoid using app logic in this folder or any descendant.

- **views** - Contains any full screen that is used in the app
- **widgets** - Contains any reusable widgets.

### Views

- **All issues view** - List of issues generated, sortable by date, popularity, controversiality(?)
- **All bills view** - List of bills sortable by house, date, progress
- **Bill page with voting option** - Full description/links and voting buttons
- **Login Page** - email - password
- **Results Page** - List of horizontal bar graphs - 1 for each electorate
- **Verification/Settings Page** - AEC details, electorate details, representatives and voting patterns, join Flux button, link settings (google/FB/Insta)

----------

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