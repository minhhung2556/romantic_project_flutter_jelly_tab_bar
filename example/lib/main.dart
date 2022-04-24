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
const kSampleIconLabels = [
  'Khuyến mãi',
  'Lịch sử',
  'Chuyển tiền',
  'Nạp tiền',
  'Tài khoản',
];

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final controller = ScrollController();
  double headerOffset = 0.0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Example',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Scaffold(
        body: Container(
          margin: const EdgeInsets.only(top: 24.0),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: SingleChildScrollView(
                    controller: controller,
                    child: Column(
                      children: [
                        Container(
                          height: headerOffset,
                        ),
                        Image.asset('assets/sample.jpg'),
                        Container(
                          height: 350,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: RoundedBottomNavigationBar(),
      ),
    );
  }
}
