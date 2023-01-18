import 'package:app_it/bodys/show_reportclean.dart';
import 'package:app_it/bodys/zone_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widget/show_confirm.dart';
import '../widget/show_logout.dart';

class MainAdmin extends StatefulWidget {
  const MainAdmin({super.key});

  @override
  State<MainAdmin> createState() => _MainAdminState();
}

class _MainAdminState extends State<MainAdmin> {
  List<Widget> widgets = [ShowReportClean(), ZonePage()];
  int indexWidget = 0;
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
          title: Text('Main Admin'),
          actions: [
            IconButton(
              onPressed: () {
                showConfirmLogout(context);
              },
              icon: Icon(Icons.exit_to_app),
            ),
          ],
        ),
        body: widgets[indexWidget],
        drawer: Drawer(
          child: ListView(
            children: [
              showHead(),
              Divider(),
              Column(
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.list,
                      size: 35.0,
                      color: Colors.pink,
                    ),
                    title: const Text(
                      'Report Cleanning',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Colors.pink),
                    ),
                    subtitle: Text('แสดงรายละเอียดรายงานที่ทำความสะอาด'),
                    onTap: () {
                      setState(() {
                        indexWidget = 0;
                      });
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              Divider(),
              ListTile(
                leading: const Icon(
                  Icons.maps_home_work_outlined,
                  size: 35.0,
                  color: Colors.pink,
                ),
                title: const Text(
                  'ZONE',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Colors.pink),
                ),
                subtitle: Text('แสดงรายละเอียดโซนที่ทำความสะอาด'),
                onTap: () {
                  setState(() {
                    indexWidget = 1;
                  });
                  Navigator.pop(context);
                },
              ),
              Divider(),
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
          ),
        ));
  }

  UserAccountsDrawerHeader showHead() {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(
        color: Colors.blueAccent,
      ),
      accountName: Text(
        '$nameUser',
        style: GoogleFonts.roboto(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      accountEmail: Text(
        '$typeUser',
        style: GoogleFonts.roboto(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      currentAccountPicture: Image.asset('images/logo2.png'),
    );
  }
}
