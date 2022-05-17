import 'package:flutter/material.dart';

const _kAnimationCurve = Curves.bounceOut;
const _kBouncingGap = 0.8;

/// This is an example of [JellyTabBar] widget.
///
/// {@tool snippet}
/// ```dart
///   JellyTabBar(
///     margin: EdgeInsets.all(16),
///     animationDuration: const Duration(milliseconds: 1600),
///     backgroundColor: const Color(0xff070606),
///     activeColor: const Color(0xff83181D),
///     iconColor: Colors.white,
///     height: 72.0,
///     padding: const EdgeInsets.only(
///         bottom: 12.0, top: 12.0, left: 12.0, right: 12.0),
///     borderRadius: 36,
///     tabItemPadding: const EdgeInsets.all(8),
///     bounceFactor: 0.3,
///     tabs: kSampleIcons.map((e) => Icon(e)).toList(),
///   ),
/// ```
/// {@end-tool}
class JellyTabBar extends StatefulWidget {
  /// [duration] : The duration to run animation.
  final Duration duration;

  /// [backgroundColor] : The background color of the tab bar.
  final Color backgroundColor;

  /// [height] : The height of the tab bar.
  final double height;

  /// [margin] : The margin of the tab bar.
  final EdgeInsets margin;

  /// [padding] : The padding of the tab bar background.
  final EdgeInsets padding;

  /// [borderRadius] : The border radius of the tab bar background.
  final double borderRadius;

  /// [activeColor] : The active icon color.
  final Color activeColor;

  /// [iconColor] : The icon color.
  final Color iconColor;

  /// [tabs] : They should be icon/image widgets without action.
  final List<Widget> tabs;

  /// [tabItemPadding] : is the padding of the icon widget inside each [tabs].
  final EdgeInsets tabItemPadding;

  /// This widget's selection and animation state.
  ///
  /// If [TabController] is not provided, then the value of [DefaultTabController.of]
  /// will be used.
  final TabController? controller;

  /// Create a Romantic Bottom Jelly TabBar.
  const JellyTabBar({
    Key? key,
    required this.tabs,
    this.duration: const Duration(milliseconds: 1600),
    this.backgroundColor: const Color(0xff070606),
    this.activeColor: const Color(0xff83181D),
    this.iconColor: Colors.white,
    this.height: 72.0,
    this.margin: EdgeInsets.zero,
    this.padding:
        const EdgeInsets.only(bottom: 12.0, top: 12.0, left: 12.0, right: 12.0),
    this.borderRadius: 36,
    this.controller,
    this.tabItemPadding: const EdgeInsets.all(8),
  }) : super(key: key);

  @override
  _JellyTabBarState createState() => _JellyTabBarState();
}

class _JellyTabBarState extends State<JellyTabBar>
    with TickerProviderStateMixin {
  late final AnimationController _animationController;
  TabController? _tabController;
  late Tween<double> _indexTween;
  final _curveTween = CurveTween(curve: _kAnimationCurve);

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: widget.duration);
    _animationController.addListener(() {
      setState(() {});
    });
    _tabController = widget.controller ??
        TabController(length: widget.tabs.length, vsync: this);
    _changeIndex(0, 0);
    super.initState();
  }

  void _changeIndex(int oldIndex, int newIndex) {
    _indexTween =
        Tween<double>(begin: oldIndex.toDouble(), end: newIndex.toDouble());
    _animationController.forward(from: 0);
    _tabController!.index = newIndex;
  }

  @override
  void didUpdateWidget(covariant JellyTabBar oldWidget) {
    if (widget.duration != oldWidget.duration) {
      _animationController.duration = widget.duration;
    }
    if (widget.controller != null && _tabController != oldWidget.controller) {
      _tabController = widget.controller!;
    }
    if (widget.tabs != oldWidget.tabs) {
      _tabController = widget.controller ??
          TabController(length: widget.tabs.length, vsync: this);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  double get animationValue => _animationController.value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      height: widget.height,
      child: CustomPaint(
        painter: _RoundedBottomNavigationBarDecoration(
          bounceFactor: 0.3,
          bezierHorizontalPartCount: 12,
          bezierVerticalPartCount: 6,
          relativeQuadraticBezierMap: [
            <double>[
              2,
              Tween<double>(begin: 1, end: 0)
                  .chain(_curveTween)
                  .evaluate(_animationController),
              3,
              Tween<double>(begin: 3, end: 2)
                  .chain(_curveTween)
                  .evaluate(_animationController)
            ],
            <double>[1, 2, 3, 2],
            <double>[2, 0, 3, -2],
            <double>[
              1,
              -2,
              3,
              Tween<double>(begin: -3, end: -2)
                  .chain(_curveTween)
                  .evaluate(_animationController)
            ],
          ],
          borderRadius: Tween<Radius>(
                  begin: Radius.circular(widget.borderRadius * 1.4),
                  end: Radius.elliptical(
                      widget.borderRadius, widget.borderRadius))
              .chain(_curveTween)
              .evaluate(_animationController),
          backgroundColor: widget.backgroundColor,
          currentIndex:
              _indexTween.chain(_curveTween).transform(animationValue),
          animationValue: _curveTween.transform(animationValue),
          length: widget.tabs.length,
          padding: widget.padding,
        ),
        child: Padding(
          padding: widget.padding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: widget.tabs
                .map((e) => _itemBuilder(context, widget.tabs.indexOf(e)))
                .toList(),
          ),
        ),
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    final selected = index == _tabController!.index;
    final child = ElevatedButton(
      onPressed: () {
        _changeIndex(_tabController!.index, index);
      },
      child: widget.tabs[index],
      style: ButtonStyle(
        shape: MaterialStateProperty.all<OutlinedBorder>(
          CircleBorder(
            side: BorderSide(color: Colors.transparent),
          ),
        ),
        padding: MaterialStateProperty.all<EdgeInsets>(widget.tabItemPadding),
        elevation: MaterialStateProperty.all<double>(0),
        tapTargetSize: MaterialTapTargetSize.padded,
        backgroundColor: MaterialStateProperty.all<Color>(
            selected ? widget.activeColor : Colors.transparent),
        overlayColor: MaterialStateProperty.all<Color>(
            widget.activeColor.withOpacity(0.8)),
        minimumSize: MaterialStateProperty.all<Size>(Size.zero),
      ),
    );
    return selected
        ? Transform.translate(
            offset: Tween<Offset>(
                    begin: Offset(0, widget.padding.bottom), end: Offset.zero)
                .chain(_curveTween)
                .transform(animationValue),
            child: child,
          )
        : child;
  }
}

class _RoundedBottomNavigationBarDecoration extends CustomPainter {
  final Color backgroundColor;
  final List<List<double>> relativeQuadraticBezierMap;
  final int bezierHorizontalPartCount;
  final int bezierVerticalPartCount;
  final Radius borderRadius;
  final double currentIndex;
  final double animationValue;
  final int length;
  final EdgeInsets padding;
  final double bounceFactor;

  const _RoundedBottomNavigationBarDecoration({
    required this.backgroundColor,
    required this.relativeQuadraticBezierMap,
    required this.bezierVerticalPartCount,
    required this.bezierHorizontalPartCount,
    required this.borderRadius,
    required this.currentIndex,
    required this.length,
    required this.padding,
    required this.animationValue,
    required this.bounceFactor,
  }) : assert(bounceFactor >= 0.1 && bounceFactor <= 1);

  @override
  void paint(Canvas canvas, Size size) {
    final reverseAnimationValue = 1 - animationValue;
    final bezierPartSizeVertical =
        (size.height - padding.vertical) / bezierVerticalPartCount;
    final bezierPartSizeHorizontal = (size.width - padding.horizontal) /
        (length / 2) /
        bezierHorizontalPartCount;
    final deltaRadius = Radius.elliptical(
        0, reverseAnimationValue * borderRadius.y * bounceFactor);
    final path = Path()
      ..moveTo(
          padding.left +
              (currentIndex * (size.width - padding.horizontal) -
                      bezierPartSizeHorizontal * bezierHorizontalPartCount) /
                  length,
          deltaRadius.y);
    for (var i = 0; i < relativeQuadraticBezierMap.length; ++i) {
      var bezier = relativeQuadraticBezierMap[i];
      var x1 = bezier[0];
      var y1 = bezier[1] * reverseAnimationValue;
      var x2 = bezier[2];
      var y2 = bezier[3] * reverseAnimationValue;

      if (i == 0) {
        x1 += -_kBouncingGap * reverseAnimationValue;
      } else if (i == 1) {
        x1 += _kBouncingGap * reverseAnimationValue;
      } else if (i == 2) {
        x1 += -_kBouncingGap * reverseAnimationValue;
      } else if (i == 3) {
        x1 += _kBouncingGap * reverseAnimationValue;
      }
      path.relativeQuadraticBezierTo(
          x1 * bezierPartSizeHorizontal,
          y1 * bezierPartSizeVertical,
          x2 * bezierPartSizeHorizontal,
          y2 * bezierPartSizeVertical);
    }

    path
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..lineTo(0, 0);

    canvas.clipPath(path);

    canvas.drawRRect(
        RRect.fromLTRBAndCorners(0, 0, size.width, size.height,
            topLeft: borderRadius + deltaRadius,
            topRight: borderRadius + deltaRadius,
            bottomLeft: borderRadius,
            bottomRight: borderRadius),
        Paint()..color = backgroundColor);
  }

  @override
  bool shouldRepaint(
      covariant _RoundedBottomNavigationBarDecoration oldDelegate) {
    return oldDelegate.backgroundColor != this.backgroundColor ||
        oldDelegate.relativeQuadraticBezierMap !=
            this.relativeQuadraticBezierMap ||
        oldDelegate.bezierVerticalPartCount != this.bezierVerticalPartCount ||
        oldDelegate.bezierHorizontalPartCount !=
            this.bezierHorizontalPartCount ||
        oldDelegate.borderRadius != this.borderRadius ||
        oldDelegate.currentIndex != this.currentIndex ||
        oldDelegate.length != this.length ||
        oldDelegate.padding != this.padding ||
        oldDelegate.animationValue != this.animationValue ||
        oldDelegate.bounceFactor != this.bounceFactor;
  }
}
