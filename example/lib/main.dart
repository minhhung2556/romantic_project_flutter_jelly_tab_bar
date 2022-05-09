import 'package:flutter/material.dart';
import 'package:flutter_liquid_tab_bar/flutter_liquid_tab_bar.dart';

void main() => runApp(MyApp());

const kSampleIcons = [
  Icons.track_changes_outlined,
  Icons.receipt_long_outlined,
  Icons.wifi_protected_setup_outlined,
  Icons.add_to_home_screen_outlined,
  Icons.ac_unit,
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(
                'https://instagram.fsgn5-3.fna.fbcdn.net/v/t51.2885-15/266328155_657743085680956_4425133777659077551_n.jpg?stp=dst-jpg_e35_p750x750_sh0.08&_nc_ht=instagram.fsgn5-3.fna.fbcdn.net&_nc_cat=104&_nc_ohc=wA1j7GahQVcAX8qTPi7&tn=_-ysDAfzeH5aYFle&edm=ALQROFkBAAAA&ccb=7-4&ig_cache_key=MjcyNzcxODkzNjM2NTA2NjE4MQ%3D%3D.2-ccb7-4&oh=00_AT8gsOvTULTnxxxCyxHdMGOciR-nXnyGVPCCiDchyovBmQ&oe=627F72C2&_nc_sid=30a2ef',
                fit: BoxFit.fitHeight,
                height: 800,
              ),
              LiquidTabBar(
                tabs: kSampleIcons.map((e) => Icon(e)).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
