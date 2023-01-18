import 'package:flutter/material.dart';

import 'forms/form_addzone.dart';

class ZonePage extends StatefulWidget {
  ZonePage({Key? key}) : super(key: key);

  @override
  State<ZonePage> createState() => _ZonePageState();
}

class _ZonePageState extends State<ZonePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('โซน'),
        centerTitle: true,
      ),
      body: Text('ยังไม่มีข้อมูล'),
      floatingActionButton: Container(
        height: 100.0,
        width: 100.0,
        child: FittedBox(
          child: FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FormAddZone()),
              );
            },
            label: Text('ADD'),
            icon: Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
