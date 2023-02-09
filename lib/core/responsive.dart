import 'package:flutter/material.dart';

class Responsive{
  MediaQueryData? mediaQueryData;

  double? _screenWidth;
  double? _screenHeight;

   void init(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    _screenWidth = mediaQueryData!.size.width;
    _screenHeight = mediaQueryData!.size.height;
  }
  double get screenHeight =>
      isDesktop ? _screenHeight! : _screenHeight! - kToolbarHeight;

  double get screenWidth => _screenWidth!;

  bool get isDesktop => _screenWidth! >= 1100;
  bool get isMobile => _screenWidth! < 850;

}