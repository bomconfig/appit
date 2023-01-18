import 'package:flutter/material.dart';

class MyConstant {
  static String domain = 'http://192.168.2.21';
  //route
  static String routeHome = '/home';
  static String routeLogin = '/login';
  static String routeSignUp = '/signup';
  static String routeMenu = '/menu';
  static String routeZone = '/zone';

  //Image
  static String logo1 = 'images/logo1.png';
  static String signup = 'images/signup.png';
  static String camera = 'images/camera.png';
  static String gallery = 'images/gallery.png';

  static String image1 = 'images/image1.png';

  // Color
  static Color primary = Color(0xff87861d);
  static Color dark = Color(0xff575900);
  static Color light = Color(0xffb9b64e);
  static Map<int, Color> mapMaterialColor = {
    50: Color.fromRGBO(255, 87, 89, 0.1),
    100: Color.fromRGBO(255, 87, 89, 0.2),
    200: Color.fromRGBO(255, 87, 89, 0.3),
    300: Color.fromRGBO(255, 87, 89, 0.4),
    400: Color.fromRGBO(255, 87, 89, 0.5),
    500: Color.fromRGBO(255, 87, 89, 0.6),
    600: Color.fromRGBO(255, 87, 89, 0.7),
    700: Color.fromRGBO(255, 87, 89, 0.8),
    800: Color.fromRGBO(255, 87, 89, 0.9),
    900: Color.fromRGBO(255, 87, 89, 1.0),
  };

  //Background
  BoxDecoration planBackground() => BoxDecoration(
        color: MyConstant.light.withOpacity(0.75),
      );

  BoxDecoration gradintLinearBackground() => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white, MyConstant.light, MyConstant.primary],
        ),
      );

  BoxDecoration gradientRadioBackground() => BoxDecoration(
        gradient: RadialGradient(
          center: Alignment(0, -0.5),
          radius: 1.5,
          colors: [Colors.white, MyConstant.primary],
        ),
      );

  // Style
  TextStyle h1Style() => TextStyle(
        fontSize: 24,
        color: dark,
        fontWeight: FontWeight.bold,
      );

  TextStyle h1SWhitetyle() => TextStyle(
        fontSize: 24,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      );

  TextStyle h1RedStyle() => TextStyle(
        fontSize: 24,
        color: Colors.red.shade900,
        fontWeight: FontWeight.bold,
      );
  TextStyle h2Style() => TextStyle(
        fontSize: 18,
        color: dark,
        fontWeight: FontWeight.w700,
      );
  TextStyle h2WhiteStyle() => TextStyle(
        fontSize: 18,
        color: Colors.white,
        fontWeight: FontWeight.w700,
      );

  TextStyle h2RedStyle() => TextStyle(
        fontSize: 18,
        color: Colors.red.shade700,
        fontWeight: FontWeight.w700,
      );

  TextStyle h2BlueStyle() => TextStyle(
        fontSize: 18,
        color: Colors.blue.shade800,
        fontWeight: FontWeight.w700,
      );
  TextStyle h3Style() => TextStyle(
        fontSize: 14,
        color: dark,
        fontWeight: FontWeight.normal,
      );
  TextStyle h3WhiteStyle() => TextStyle(
        fontSize: 14,
        color: Colors.white,
        fontWeight: FontWeight.normal,
      );

  ButtonStyle myButtonStyle() => ElevatedButton.styleFrom(
        backgroundColor: MyConstant.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      );
}
