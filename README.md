# guten_app

Flutter project to show project gutenberg

## Intro

This project is part of challenge from xyz_goat, 
In this challenge, I picked option B which is designing a long term project
for 5 team members, I picked this because it can emulate the real working situation.

## Run this project
### requirement
- Flutter version 3.10.2
- sdk: ">=2.18.0 <3.0.0"

### running
before running the project, we need to generate model class using build_runner, 
can simply execute this command:
```
flutter packages pub run build_runner build --delete-conflicting-outputs  
```
for running debug build:
```
flutter run -t lib/main_dev.dart
```

for build prd android:
```
flutter build appbundle
```

for build prd iOS:
```
flutter build ipa
```

### project demo
| demo |
| - |
| https://drive.google.com/file/d/1bBC4mhJt3agz7UEhhagXFSQED3QCb_U4/view?usp=sharing |