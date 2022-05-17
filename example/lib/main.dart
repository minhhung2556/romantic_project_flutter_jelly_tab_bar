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
