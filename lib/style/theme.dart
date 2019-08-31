import 'dart:ui';

import 'package:flutter/cupertino.dart';

class Colors {

  const Colors();

  static const Color loginGradientStart = const Color(0xAAFFFFFF); //c0c0c0 grey
  static const Color loginGradientEnd = const Color(0xFFc0c0c0); //a9a9a9
  static const Color loginButtonGradientEnd = const Color(0xFFFDB812);
  static const Color buttonGradientStart = const Color(0xAA000099); //c0c0c0 grey
  static const Color buttonGradientEnd = const Color(0xF000099); //a9a9a9


  static const primaryGradient = const LinearGradient(
    colors: const [loginGradientStart, loginGradientEnd],
    stops: const [0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}