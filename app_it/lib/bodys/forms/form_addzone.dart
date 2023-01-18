import 'dart:io';

import 'package:app_it/utility/myconstan.dart';
import 'package:app_it/widget/show_image.dart';
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
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(height: 30),
                        addZone(size),
                        SizedBox(height: 30),
                        addDetailZone(size),
                        SizedBox(height: 30),
                        //buildImage(constraints),
                        addImage(constraints),
                        SizedBox(height: 30),
                        buildButtonSave(constraints),
                      ],
                    ),
                  ),
                ),
              )),
    );
  }

  Row addImage(BoxConstraints constraints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.add_a_photo),
        ),
        Container(
          width: 250,
          child: Image.asset(MyConstant.gallery),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.add_photo_alternate),
        ),
      ],
    );
  }

  // Future<void> processImagePiker(ImageSource source, int index) async {
  //   try {
  //     var result = await _picker.pickImage(
  //       source: source,
  //       maxWidth: 400,
  //       maxHeight: 400,
  //     );
  //     setState(() {
  //       file = File(result!.path);
  //       files[index] = file;
  //     });
  //   } catch (e) {
  //     debugPrint('Failed to pick image: $e');
  //   }
  // }

  // Future<void> chooseSourceImageDialog(int index) async {
  //   debugPrint('Click from index ===> $index');
  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: ListTile(
  //         leading: ShowImagePage(path: MyConstant.logo1),
  //         title: Text('source image ${index + 1} ?'),
  //         subtitle: const Text('กรุณาเลือก Camera หรือ Gallery!'),
  //       ),
  //       actions: [
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceAround,
  //           children: [
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.pop(context);
  //                 processImagePiker(ImageSource.camera, index);
  //               },
  //               child: const Text('Camera'),
  //             ),
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.pop(context);
  //                 processImagePiker(ImageSource.gallery, index);
  //               },
  //               child: const Text('Gallery'),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Column buildImage(BoxConstraints constraints) {
  //   return Column(
  //     children: [
  //       Container(
  //           margin: const EdgeInsets.only(top: 15.0),
  //           width: constraints.maxWidth * 0.50,
  //           height: constraints.maxWidth * 0.50,
  //           child: file == null
  //               ? Image.asset(MyConstant.gallery)
  //               : Image.file(file!)),
  //       Container(
  //         margin: const EdgeInsets.only(top: 5.0),
  //         width: constraints.maxWidth * 0.8,
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Container(
  //               margin: const EdgeInsets.only(top: 5.0),
  //               width: 48,
  //               height: 48,
  //               child: InkWell(
  //                 onTap: () => chooseSourceImageDialog(0),
  //                 child: files[0] == null
  //                     ? Image.asset(MyConstant.gallery)
  //                     : Image.file(
  //                         files[0]!,
  //                         fit: BoxFit.cover,
  //                       ),
  //               ),
  //             ),
  //             Container(
  //               margin: const EdgeInsets.only(top: 5.0),
  //               width: 48,
  //               height: 48,
  //               child: InkWell(
  //                 onTap: () => chooseSourceImageDialog(1),
  //                 child: files[1] == null
  //                     ? Image.asset(MyConstant.gallery)
  //                     : Image.file(
  //                         files[1]!,
  //                         fit: BoxFit.cover,
  //                       ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Container addDetailZone(double size) {
    return Container(
      width: size * 0.75,
      child: TextFormField(
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

  Container buildButtonSave(BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth * 0.25,
      margin: const EdgeInsets.only(top: 10.0, bottom: 30.0),
      child: ElevatedButton(
        onPressed: () {},
        child: Text('UP Load'),
      ),
    );
  }
}
