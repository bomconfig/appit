import 'package:flutter/material.dart';

class ShowReportClean extends StatefulWidget {
  ShowReportClean({Key? key}) : super(key: key);

  @override
  State<ShowReportClean> createState() => _ShowReportCleanState();
}

class _ShowReportCleanState extends State<ShowReportClean> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('รายงานการทำความสะอาด'),
        centerTitle: true,
      ),
    );
  }
}
