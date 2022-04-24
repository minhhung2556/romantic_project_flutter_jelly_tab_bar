import 'package:flutter/material.dart';

class RoundedBottomNavigationBar extends StatefulWidget {
  final Duration animationDuration;
  final int currentIndex;
  final int length;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final Curve animationCurve;
  final Color backgroundColor;
  final double height;

  const RoundedBottomNavigationBar({
    Key? key,
    this.animationDuration: const Duration(milliseconds: 400),
    this.currentIndex: 0,
    this.length: 0,
    required this.itemBuilder,
    this.animationCurve: Curves.decelerate,
    this.backgroundColor: Colors.white,
    this.height: 64,
  }) : super(key: key);

  @override
  _RoundedBottomNavigationBarState createState() =>
      _RoundedBottomNavigationBarState();
}

class _RoundedBottomNavigationBarState extends State<RoundedBottomNavigationBar>
    with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late int currentIndex;
  @override
  void didUpdateWidget(covariant RoundedBottomNavigationBar oldWidget) {
    if (widget.currentIndex != oldWidget.currentIndex) {
      _animationController.forward(from: 0);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    currentIndex = widget.currentIndex;
    _animationController =
        AnimationController(vsync: this, duration: widget.animationDuration);
    _animationController.addListener(() {
      setState(() {});
    });
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          currentIndex = widget.currentIndex;
        });
      }
    });
    _animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 0.0,
      shadowColor: Colors.transparent,
      child: SizedBox(
        height: widget.height,
        child: CustomPaint(
          painter: _RoundedBottomNavigationBarDecoration(
            backgroundColor: widget.backgroundColor,
            currentIndex: Tween<double>(
                    begin: currentIndex.toDouble(),
                    end: widget.currentIndex.toDouble())
                .chain(CurveTween(curve: widget.animationCurve))
                .transform(_animationController.value),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              widget.length,
              (index) => widget.currentIndex == index
                  ? Transform.translate(
                      offset: Tween<Offset>(
                              begin: Offset.zero,
                              end: Offset(0, -widget.height / 10))
                          .chain(CurveTween(curve: widget.animationCurve))
                          .transform(_animationController.value),
                      child: widget.itemBuilder(context, index),
                    )
                  : widget.itemBuilder(context, index),
            ),
          ),
        ),
      ),
    );
  }
}

class _RoundedBottomNavigationBarDecoration extends CustomPainter {
  final double currentIndex;
  final Color backgroundColor;

  const _RoundedBottomNavigationBarDecoration({
    required this.currentIndex,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final partW = size.width / 5;
    final verticalPadding = 2.0;
    final partCount = 4;
    final partCountHalf = partCount / 2;
    final partSize = size.height / partCount;

    final path = Path()
      ..moveTo((currentIndex + 0.5) * partW - partSize * partCount, 0)
      ..relativeQuadraticBezierTo(partCountHalf * partSize, 0,
          partCountHalf * partSize, partCountHalf * partSize)
      ..relativeQuadraticBezierTo(0, partCountHalf * partSize - verticalPadding,
          partCountHalf * partSize, partCountHalf * partSize - verticalPadding)
      ..relativeQuadraticBezierTo(partCountHalf * partSize, 0,
          partCountHalf * partSize, -partCountHalf * partSize + verticalPadding)
      ..relativeQuadraticBezierTo(0, -partCountHalf * partSize,
          partCountHalf * partSize, -partCountHalf * partSize)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..lineTo(0, 0);
    canvas.clipPath(path);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height),
        Paint()..color = backgroundColor);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
