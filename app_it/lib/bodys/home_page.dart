import 'package:app_it/bodys/main_admin.dart';
import 'package:app_it/bodys/main_user.dart';
import 'package:app_it/utility/mydialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utility/myconstan.dart';
import '../widget/show_image.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    checkPreferanceLogin();
  }

  Future<Null> checkPreferanceLogin() async {
    try {
      SharedPreferences prefe = await SharedPreferences.getInstance();
      String? choosetype = prefe.getString('type');
      if (choosetype != null || choosetype!.isEmpty) {
        if (choosetype == 'user') {
          routeToservice(MainUser());
        } else if (choosetype == 'admin') {
          routeToservice(MainAdmin());
        } else {
          MyDialog().normalDialog2(context, 'Error User Type');
        }
      } else {
        print('error login');
      }
    } catch (e) {
      print(e);
    }
  }

  void routeToservice(Widget myWidget) async {
    SharedPreferences prefe = await SharedPreferences.getInstance();
    MaterialPageRoute route = MaterialPageRoute(builder: (context) => myWidget);
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.blueGrey, Colors.white],
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildLogo(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildButtonLogin(size),
                const SizedBox(width: 10),
                buildButtonSignup(size),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container buildButtonSignup(double size) {
    return Container(
      width: size * 0.35,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/signup');
        },
        child: Text(
          'Signup',
          style: GoogleFonts.roboto(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  Container buildButtonLogin(double size) {
    return Container(
      width: size * 0.35,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/login');
        },
        child: Text(
          'Login',
          style: GoogleFonts.roboto(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  Container buildLogo() {
    return Container(
      width: 300.0,
      child: ShowImagePage(path: MyConstant.signup),
    );
  }
}
