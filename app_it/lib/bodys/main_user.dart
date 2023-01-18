import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widget/show_confirm.dart';
import '../widget/show_logout.dart';

class MainUser extends StatefulWidget {
  const MainUser({super.key});

  @override
  State<MainUser> createState() => _MainUserState();
}

class _MainUserState extends State<MainUser> {
  String? nameUser, typeUser;

  @override
  void initState() {
    super.initState();
    findUser();
  }

  Future<Null> findUser() async {
    SharedPreferences prefe = await SharedPreferences.getInstance();
    setState(() {
      nameUser = prefe.getString('name');
      typeUser = prefe.getString('type');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main User'),
        
        actions: [
          IconButton(
              onPressed: () {
                showConfirmLogout(context);
              },
              icon: Icon(Icons.exit_to_app))
        ],
      ),
      body: Text('$nameUser'),
      drawer: Drawer(
          child: ListView(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Colors.yellow,
            ),
            accountName: Text(
              '$nameUser',
              style: GoogleFonts.roboto(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
            accountEmail: Text(
              '$typeUser',
              style: GoogleFonts.roboto(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
            currentAccountPicture: Image.asset('images/logo3.png'),
          ),
          ListTile(
            trailing: const Icon(
              Icons.logout,
              size: 35.0,
              color: Colors.pink,
            ),
            title: const Text(
              'Logout',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.pink),
            ),
            onTap: () async {
              showLogout(context);
            },
          ),
        ],
      )),
    );
  }
}
