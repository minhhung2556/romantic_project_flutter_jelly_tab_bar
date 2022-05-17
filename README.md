# Flutter Romantic Bottom Jelly Tab Bar

A Flutter package to create a Romantic Bottom Jelly Tab Bar. It will be useful for your awesome app.

This is a present from Romantic Project. More from [Romantic Developer](https://pub.dev/publishers/romanticdeveloper.com/packages)

![Demo](./demo.gif)

### Example

```dart
import 'package:flutter/material.dart';
import 'package:flutter_jelly_tab_bar/flutter_jelly_tab_bar.dart';

void main() => runApp(MyApp());

const kSampleIcons = [
  Icons.track_changes_outlined,
  Icons.receipt_long_outlined,
  Icons.wifi_protected_setup_outlined,
  Icons.add_to_home_screen_outlined,
];

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Example',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              children: [
                Expanded(
                  child: Image.asset(
                    'assets/a.jpeg',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            JellyTabBar(
              margin: EdgeInsets.all(16),
              tabs: kSampleIcons.map((e) => Icon(e)).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
```

### Development environment

```
[✓] Flutter (Channel stable, 2.10.1, on macOS 12.3.1 21E258 darwin-x64, locale en-VN)
    • Flutter version 2.10.1 at ~/fvm/versions/stable
    • Upstream repository https://github.com/flutter/flutter.git
    • Framework revision db747aa133 (2 months ago), 2022-02-09 13:57:35 -0600
    • Engine revision ab46186b24
    • Dart version 2.16.1
    • DevTools version 2.9.2

[✓] Android toolchain - develop for Android devices (Android SDK version 30.0.3)
    • Android SDK at ~/Library/Android/sdk
    • Platform android-31, build-tools 30.0.3
    • ANDROID_HOME = ~/Library/Android/sdk
    • ANDROID_SDK_ROOT = ~/Library/Android/sdk
    • Java binary at: /Applications/Android Studio 2020.3.app/Contents/jre/Contents/Home/bin/java
    • Java version OpenJDK Runtime Environment (build 11.0.10+0-b96-7281165)
    • All Android licenses accepted.

[✓] Xcode - develop for iOS and macOS (Xcode 13.3.1)
    • Xcode at /Applications/Xcode.app/Contents/Developer
    • CocoaPods version 1.11.2
    
[✓] Android Studio (version 2020.3)
    • Android Studio at /Applications/Android Studio 2020.3.app/Contents
    • Flutter plugin can be installed from:
      🔨 https://plugins.jetbrains.com/plugin/9212-flutter
    • Dart plugin can be installed from:
      🔨 https://plugins.jetbrains.com/plugin/6351-dart
    • Java version OpenJDK Runtime Environment (build 11.0.10+0-b96-7281165)
```