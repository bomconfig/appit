import 'package:flutter/material.dart';

class ShowImagePage extends StatelessWidget {
  final String path;
  const ShowImagePage({Key? key, required this.path}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(path);
  }
}
