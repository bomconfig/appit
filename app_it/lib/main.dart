import 'package:app_it/pages/menu.dart';
import 'package:app_it/bodys/signup.dart';
import 'package:app_it/utility/myconstan.dart';
import 'package:flutter/material.dart';

import 'bodys/home_page.dart';
import 'bodys/login.dart';
import 'bodys/zone_page.dart';

final Map<String, WidgetBuilder> map = {
  '/home': (BuildContext context) => HomePage(),
  '/login': (BuildContext context) => Login(),
  '/signup': (BuildContext context) => SignUp(),
  '/menu': (BuildContext context) => MenuPage(),
  '/zone': (BuildContext context) => ZonePage(),
};
String? initlalRoute;
void main() {
  initlalRoute = MyConstant.routeHome;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AppIT',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      darkTheme:
          ThemeData(brightness: Brightness.dark, primarySwatch: Colors.grey),
      routes: map,
      initialRoute: initlalRoute,
    );
  }
}
