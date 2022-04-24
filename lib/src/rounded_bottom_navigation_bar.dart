import 'package:flutter/material.dart';

class RoundedBottomNavigationBar extends StatefulWidget {
  RoundedBottomNavigationBar({Key? key}) : super(key: key);

  @override
  _RoundedBottomNavigationBarState createState() =>
      _RoundedBottomNavigationBarState();
}

class _RoundedBottomNavigationBarState
    extends State<RoundedBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: SizedBox(
          height: 54,
          child: CustomPaint(
            painter: _RoundedBottomNavigationBarDecoration(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkResponse(
                  child: Icon(Icons.settings),
                  onTap: () {},
                ),
                InkResponse(
                  child: Icon(Icons.settings),
                  onTap: () {},
                ),
                Container(),
                InkResponse(
                  child: Icon(Icons.settings),
                  onTap: () {},
                ),
                InkResponse(
                  child: Icon(Icons.settings),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RoundedBottomNavigationBarDecoration extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    final bg = Color(0xff343434);
    final fg = Colors.white;
    canvas.drawRect(
        Rect.fromLTWH(0, 0, size.width, size.height), Paint()..color = bg);

    canvas.drawRect(
        Rect.fromLTWH(size.width / 2 - size.height / 2, size.height / 2,
            size.height, size.height / 2),
        Paint()..color = fg);
    var path = Path()
      ..moveTo(size.width / 2 - size.height / 2, size.height / 2)
      ..arcTo(
          Rect.fromLTWH(
              size.width / 2 - size.height / 2, 0, size.height, size.height),
          0,
          270,
          true);
    canvas.drawPath(path, Paint()..color = bg);

    canvas.drawRRect(
        RRect.fromRectAndCorners(
            Rect.fromLTWH(
                0, 5, size.width / 2 - size.height / 2, size.height - 5),
            topRight: Radius.circular(16)),
        Paint()..color = fg);
    canvas.drawRRect(
        RRect.fromRectAndCorners(
            Rect.fromLTWH(size.width / 2 + size.height / 2, 5, size.width,
                size.height - 5),
            topLeft: Radius.circular(16)),
        Paint()..color = fg);
    //
    // canvas.drawRect(
    //     Rect.fromCenter(
    //         center: size.center(Offset.zero),
    //         width: size.height,
    //         height: size.height),
    //     Paint()..color = bg);
    //
    // var center = size.center(Offset.zero) - Offset(0, 5);
    // canvas.drawCircle(center, size.height / 2, Paint()..color = bg);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
