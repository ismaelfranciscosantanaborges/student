import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  const Responsive({
    Key key,
    @required this.mobile,
    this.tablet,
    @required this.desktop,
  }) : super(key: key);

  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  static bool isMobile(context) => MediaQuery.of(context).size.width < 800;
  static bool isTable(context) =>
      MediaQuery.of(context).size.width >= 800 &&
      MediaQuery.of(context).size.width < 1200;
  static bool isDesktop(context) => MediaQuery.of(context).size.width >= 1200;
  @override
  Widget build(BuildContext context) {
    final _screenSizeW = MediaQuery.of(context).size.width;
    if (_screenSizeW < 800) return mobile;
    if (_screenSizeW < 1200) return tablet ?? mobile;
    return desktop;
  }
}
