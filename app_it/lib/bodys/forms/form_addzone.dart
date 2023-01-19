import 'dart:io';
import 'dart:math';

import 'package:app_it/utility/myconstan.dart';
import 'package:app_it/utility/mydialog.dart';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

class FormAddZone extends StatefulWidget {
  const FormAddZone({Key? key}) : super(key: key);

  @override
  State<FormAddZone> createState() => _FormAddZoneState();
}

class _FormAddZoneState extends State<FormAddZone> {
  bool isLoading = true;
  List<File?> files = [];
  File? file;
  final ImagePicker _picker = ImagePicker();

  String? zone, detail, urlImage;

  @override
  void initState() {
    super.initState();
    initialFile();
  }

  void initialFile() {
    for (var i = 0; i < 2; i++) {
      files.add(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Zone'),
      ),
      body: LayoutBuilder(
          builder: (context, constraints) => GestureDetector(
                onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                behavior: HitTestBehavior.opaque,
                child: ListView(
                  children: [
                    Center(
                      child: Column(
                        children: [
                          SizedBox(height: 30),
                          addZone(size),
                          SizedBox(height: 30),
                          addDetailZone(size),
                          SizedBox(height: 30),
                          addImage(constraints),
                          SizedBox(height: 30),
                          saveZone(constraints),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
    );
  }

  Row addImage(BoxConstraints constraints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.add_a_photo),
          onPressed: () => processImagePiker(ImageSource.camera),
        ),
        Container(
          margin: const EdgeInsets.only(top: 15.0),
          width: constraints.maxWidth * 0.50,
          height: constraints.maxWidth * 0.50,
          child: file == null
              ? Image.asset(MyConstant.gallery)
              : Image.file(file!),
        ),
        IconButton(
          icon: Icon(Icons.add_photo_alternate),
          onPressed: () => processImagePiker(ImageSource.gallery),
        ),
      ],
    );
  }

  Future<void> processImagePiker(ImageSource source) async {
    try {
      var result = await _picker.pickImage(
        source: source,
        maxWidth: 400,
        maxHeight: 400,
      );
      setState(() {
        file = File(result!.path);
        // files[index] = file;
      });
    } catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Container addDetailZone(double size) {
    return Container(
      width: size * 0.75,
      child: TextFormField(
        onChanged: ((value) => detail = value.trim()),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.location_on_outlined,
            color: Colors.pink,
          ),
          labelText: 'รายละเอียด Zone',
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

  Container addZone(double size) {
    return Container(
      width: size * 0.75,
      child: TextFormField(
        onChanged: ((value) => zone = value.trim()),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.location_on_outlined,
            color: Colors.pink,
          ),
          labelText: 'Zone',
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

  Future<Null> uploadImage() async {
    Random random = Random();
    int i = random.nextInt(100000);
    String nameImageZone = 'zone$i.jpg';

    try {
      Map<String, dynamic> map = Map();
      map['file'] =
          await MultipartFile.fromFile(file!.path, filename: nameImageZone);

      FormData formData = FormData.fromMap(map);
      await Dio()
          .post('${MyConstant.domain}/api_appit/saveAddFileZone.php',
              data: formData)
          .then((value) => {print('Response = $value')});
      urlImage = '${MyConstant.domain}/api_appit/zone/$nameImageZone';
      print('urlImage = $urlImage');
    } catch (e) {
      print(e);
    }
  }

  Container saveZone(BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth * 0.25,
      margin: const EdgeInsets.only(top: 10.0, bottom: 30.0),
      child: ElevatedButton(
        onPressed: () {
          if (zone == null ||
              zone!.isEmpty ||
              detail == null ||
              detail!.isEmpty) {
            MyDialog().normalDialog2(context, "กรุณากรอกให้ครบทุกช่อง");
          } else if (file == null) {
            MyDialog().normalDialog2(context, "กรุณาเลือก รูปภาพ");
          } else {
            uploadImage();
          }
        },
        child: Text('Up Load'),
      ),
    );
  }
}
