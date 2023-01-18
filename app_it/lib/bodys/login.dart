import 'dart:convert';

import 'package:app_it/bodys/main_admin.dart';
import 'package:app_it/bodys/main_user.dart';
import 'package:app_it/models/user_model.dart';
import 'package:app_it/utility/mydialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utility/myconstan.dart';
import '../widget/show_image.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _ctrUsername = TextEditingController();
  final TextEditingController _ctrPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  //firld
  String? username, password;

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.blueGrey, Colors.white],
        )),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(
            FocusNode(),
          ),
          behavior: HitTestBehavior.opaque,
          child: Container(
            child: ListView(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      buildImage(),
                      const SizedBox(height: 35.0),
                      buildUser(size),
                      const SizedBox(height: 20.0),
                      buildPassword(size),
                      const SizedBox(height: 20.0),
                      buildButtonLogin(size),
                      buildSignup(size)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

//เช็ด authen user
  Future<Null> checkAuthen() async {
    try {
      var response = await Dio().get(
          'http://192.168.2.21/api_appit/getUserWhereUser.php?isAdd=true&user=$username');
      //print('res = $response');

      var result = json.decode(response.data);
      print('result = $result');
      for (var map in result) {
        UserModel userModel = UserModel.fromJson(map);

        if (password == userModel.password) {
          String? choosetype = userModel.type;
          if (choosetype == 'user') {
            routeToservice(MainUser(), userModel);
          } else if (choosetype == 'admin') {
            routeToservice(MainAdmin(), userModel);
          } else {
            MyDialog().normalDialog2(context, 'Error!');
          }
        } else {
          MyDialog()
              .normalDialog2(context, 'Password = $password ผิด กรุณาลองใหม่');
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<Null> routeToservice(Widget myWidget, UserModel userModel) async {
    SharedPreferences prefe = await SharedPreferences.getInstance();
    prefe.setString('id', userModel.id.toString());
    prefe.setString('type', userModel.type.toString());
    prefe.setString('name', userModel.name.toString());

    MaterialPageRoute route = MaterialPageRoute(builder: (context) => myWidget);
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  Container buildSignup(double size) {
    return Container(
      width: size * 0.75,
      child: Row(
        children: [
          Text(
            'No User Click here  ',
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/signup');
            },
            child: Text(
              'SignUp!',
              style: GoogleFonts.robotoMono(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          )
        ],
      ),
    );
  }

  Container buildButtonLogin(double size) {
    return Container(
      width: size * 0.75,
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            String username = _ctrUsername.text;
            String password = _ctrPassword.text;
            //print('##user = $username, password = $password ');
          }

          if (username == null ||
              username!.isEmpty ||
              password == null ||
              password!.isEmpty) {
            MyDialog().normalDialog(
                context, '* มีช่องว่าง', 'กรุณากรอก Username และ Password');
          } else {
            checkAuthen();
          }
        },
        child: Text(
          'Login',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Container buildPassword(double size) {
    return Container(
      width: size * 0.75,
      child: TextFormField(
        onChanged: (value) => password = value.trim(),
        validator: (value) {
          if (value!.isEmpty) {
            return 'กรุณากรอก password!';
          }
          return null;
        },
        controller: _ctrPassword,
        obscureText: true,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.lock_outline,
            color: Colors.pink,
          ),
          labelText: 'Password',
          labelStyle: TextStyle(color: Colors.pink),
          fillColor: Colors.white70,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
    );
  }

  Container buildUser(double size) {
    return Container(
      width: size * 0.75,
      child: TextFormField(
        onChanged: (value) => username = value.trim(),
        validator: (value) {
          if (value!.isEmpty) {
            return 'กรุณากรอก username!';
          }
          return null;
        },
        controller: _ctrUsername,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.account_circle_outlined,
            color: Colors.pink,
          ),
          labelText: 'Username',
          labelStyle: TextStyle(color: Colors.pink),
          fillColor: Colors.white70,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
    );
  }

  Container buildImage() {
    return Container(
      width: 300.0,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(80.0),
          bottomRight: Radius.circular(80.0),
        ),
      ),
      child: ShowImagePage(path: MyConstant.signup),
    );
  }
}
