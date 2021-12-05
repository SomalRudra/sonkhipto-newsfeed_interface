import 'package:flutter/material.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;

  static late double blockSizeHorizontal;
  static late double blockSizeVertical;

  static late double _safeAreaHorizontal;
  static late double _safeAreaVertical;
  static late double safeBlockHorizontal;
  static late double safeBlockVertical;
  static late double bodyHeight;
  static late double bodyWidth;

  static Size getScreenSize(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return size;
  }

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    bodyWidth = _mediaQueryData.size.width;
    bodyHeight = _mediaQueryData.size.height -
        kToolbarHeight -
        MediaQuery.of(context).padding.top;

    blockSizeHorizontal = bodyWidth / 100;
    blockSizeVertical = bodyHeight / 100;

    _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (bodyWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (bodyHeight - _safeAreaVertical) / 100;
  }
}
