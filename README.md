# Payment Card - Flutter Project

_USP: Zero data usage, Zero Permissions required_

_Use: Keep your Debit/Credit details here so that you don't to search for your wallet._

## Setup
1. Install android-sdk (Search in intelliJ preference and get it done)

2. Install inteiiJ Plugins - flutter and Dart

3. Install Flutter SDK etc
```
brew install --cask flutter
flutter doctor -v
```
## App Signing
Step 1: `flutter pub pub run flutter_automation --android-sign`. This will create a file `local.properties` file in /android with the password and jks file location

Step 2: `flutter build apk --target-platform android-arm,android-arm64,android-x64 --split-per-abi`
or
`flutter build appbundle`

Step 3: Apps/AppBundle will be created in /build/app/outputs/apk or bundle