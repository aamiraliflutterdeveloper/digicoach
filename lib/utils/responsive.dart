import 'package:flutter/material.dart';

class Responsive {
  double? _screenWidth;
  double? _screenHeight;

  void init(BuildContext context) {
    final size = MediaQuery.of(context).size!;
    _screenWidth = size.width;
    _screenHeight = size.height;
  }

  double get screenHeight =>
      isDesktop ? _screenHeight! : _screenHeight! - kToolbarHeight;

  double get screenWidth => _screenWidth!;

  bool get isDesktop => _screenWidth! >= 1100;
  bool get isMobile => _screenWidth! < 850;
}
