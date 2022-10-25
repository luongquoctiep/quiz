import 'package:flutter/material.dart';

class ThemeHelper {
  static Color primaryColor = const Color(0xff6758C0);
  static Color accentColor = const Color(0xff20aebe);
  static Color shadowColor = const Color(0xffa2a6af);

  static ThemeData getThemeData() {
    return ThemeData(
      fontFamily: 'Baloo',
      primarySwatch: Colors.deepPurple,
      colorScheme: const ColorScheme.light(
          primary: Colors.deepPurple, secondary: Colors.teal),
      textTheme: TextTheme(
          headline3: TextStyle(
            color: accentColor,
            fontFamily: 'Baloo',
          ),
          headline4: TextStyle(
            color: accentColor,
            fontFamily: 'Baloo',
          )),
    );
  }

  static BoxDecoration fullScreenBgBoxDecoration(
      {String backgroundAssetImage = "assets/images/Common.bg.png"}) {
    return BoxDecoration(
      image: DecorationImage(
          image: AssetImage(backgroundAssetImage), fit: BoxFit.cover),
    );
  }

  static roundBoxDeco({Color color = Colors.white, double radius = 15}) {
    return BoxDecoration(
        color: color, borderRadius: BorderRadius.all(Radius.circular(radius)));
  }
}
