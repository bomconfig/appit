import 'package:app_it/utility/my_style.dart';
import 'package:app_it/utility/mydialog.dart';
import 'package:app_it/widget/show_title.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';

import '../utility/myconstan.dart';
import '../widget/show_image.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // final TextEditingController _ctrType = TextEditingController();
  // final TextEditingController _ctrName = TextEditingController();
  // final TextEditingController _ctrUser = TextEditingController();
  // final TextEditingController _ctrPassword = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String? chooseType, name, username, password;

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('SignUp'),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(
          FocusNode(),
        ),
        behavior: HitTestBehavior.opaque,
        child: Container(
          child: ListView(
            children: [
              Form(
                key: _formKey,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        buildImage(),
                        buildName(size),
                        buildUser(size),
                        buildPassword(size),
                        const SizedBox(height: 20.0),
                        const ShowTitle(title: 'ชนิดผู้ใช้'),
                        adminRadio(size),
                        userRadio(size),
                        const SizedBox(height: 20.0),
                        buildButtonSignup(size),
                        buildLogin(size)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Null> checkUser() async {
    try {
      var response = await Dio().get(
          'http://192.168.2.21/api_appit/getUserWhereUser.php?isAdd=true&user=$username');
      if (response.toString() == 'null') {
        signupThread();
      } else {
        MyDialog().normalDialog(
            context, '$username ถูกใช้ไปแล้ว', 'กรุณาใช้ username อื่น');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> signupThread() async {
    try {
      var response = await Dio().get(
          'http://192.168.2.21/api_appit/insertData.php?isAdd=true&type=$chooseType&name=$name&user=$username&password=$password');
      print(response.data);
      if (response.toString() == "true") {
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        MyDialog().normalDialog(context, 'Field', 'กรุณาลงทะเบียนใหม่');
      }
    } catch (e) {
      print(e);
    }
  }

  Container buildImage() {
    return Container(
      width: 180.0,
      decoration: const BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(100.0),
          bottomRight: Radius.circular(100.0),
          topLeft: Radius.circular(100.0),
          topRight: Radius.circular(100.0),
        ),
      ),
      child: ShowImagePage(path: MyConstant.signup),
    );
  }

  Container buildName(double size) {
    return Container(
      width: size * 0.75,
      child: TextFormField(
        onChanged: (value) => name = value.trim(),
        validator: (value) {
          if (value!.isEmpty) {
            return 'กรุณากรอก name!';
          }
          return null;
        },
        //controller: _ctrName,
        decoration:
            InputDecoration(prefixIcon: Icon(Icons.face), labelText: "name : "),
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
            return 'กรุณากรอก Username!';
          }
          return null;
        },
        //controller: _ctrUser,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.person), labelText: "Username : "),
      ),
    );
  }

  Container buildPassword(double size) {
    return Container(
      width: size * 0.75,
      child: TextFormField(
        onChanged: ((value) => password = value.trim()),
        validator: (value) {
          if (value!.isEmpty) {
            return 'กรุณากรอก Password!';
          }
          return null;
        },
        obscureText: true,
        //controller: _ctrPassword,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.key),
          labelText: "Password : ",
        ),
      ),
    );
  }

  Row adminRadio(double size) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: size * 0.50,
            child: Row(
              children: [
                Radio(
                    value: 'admin',
                    groupValue: chooseType,
                    onChanged: (value) {
                      setState(() {
                        chooseType = value;
                      });
                    }),
                Text(
                  'แอดมิน',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      );
  Row userRadio(double size) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: size * 0.50,
            child: Row(
              children: [
                Radio(
                    value: 'user',
                    groupValue: chooseType,
                    onChanged: (value) {
                      setState(() {
                        chooseType = value;
                      });
                    }),
                Text(
                  'ผู้ใช้งาน',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      );

  Container buildButtonSignup(double size) {
    return Container(
      width: size * 0.75,
      child: ElevatedButton(
        onPressed: () {
          print(
              'name = $name, user = $username, password = $password, chooseType = $chooseType  ');
          if (_formKey.currentState!.validate()) {}

          if (name == null ||
              name!.isEmpty ||
              username == null ||
              username!.isEmpty ||
              password == null ||
              password!.isEmpty) {
            print('มีช่องว่าง');
            MyDialog().normalDialog(
              context,
              '*มีช่องว่าง!',
              'กรุณากรอกให้ครบทุกช่อง name = $name, user = $username, password = $password',
            );
          } else if (chooseType == null) {
            MyDialog().normalDialog(
              context,
              'เลือกชนิดของผู้ใช้',
              "chooseType = $chooseType",
            );
          } else {
            checkUser();
          }
        },
        child: Text(
          'Signup',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Container buildLogin(double size) {
    return Container(
      width: size * 0.75,
      child: Row(
        children: [
          Text(
            'Already have an Account? ',
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
            child: Text(
              'Login!',
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
}
