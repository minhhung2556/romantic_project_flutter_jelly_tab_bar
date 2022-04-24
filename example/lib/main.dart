import 'package:flutter/material.dart';
import 'package:flutter_rounded_bottom_navigation_bar/flutter_rounded_bottom_navigation_bar.dart';

void main() => runApp(MyApp());

const kSampleIcons = [
  Icons.track_changes_outlined,
  Icons.receipt_long_outlined,
  Icons.wifi_protected_setup_outlined,
  Icons.add_to_home_screen_outlined,
  Icons.account_box_outlined,
];

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Example',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/sample.jpg',
                    ),
                    Image.network(
                      'https://cdn.wallpapersafari.com/66/30/ez6LG9.jpg',
                      fit: BoxFit.fitHeight,
                      alignment: Alignment(0.7, 0.0),
                      height: 1200,
                    ),
                  ],
                ),
              ),
              Align(
                child: RoundedBottomNavigationBar(
                  currentIndex: index,
                  length: kSampleIcons.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ElevatedButton(
                      child: Icon(
                        kSampleIcons[index],
                      ),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                            CircleBorder(
                          side: BorderSide(color: Colors.transparent),
                        )),
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.all(12)),
                        elevation: MaterialStateProperty.all<double>(0),
                        tapTargetSize: MaterialTapTargetSize.padded,
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.deepOrangeAccent),
                        overlayColor:
                            MaterialStateProperty.all<Color>(Colors.black26),
                        minimumSize: MaterialStateProperty.all<Size>(Size.zero),
                      ),
                      onPressed: () {
                        setState(() {
                          this.index = index;
                        });
                      },
                    );
                  },
                ),
                alignment: Alignment.bottomCenter,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
