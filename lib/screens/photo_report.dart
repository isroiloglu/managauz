import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:manageuz/constants.dart';
import 'package:manageuz/models/foto_hive_model.dart';
import 'package:manageuz/widgets/custom_camera_dialog.dart';
import 'package:manageuz/widgets/nav_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PhotoReport extends StatefulWidget {
  final int customerId;

  PhotoReport({Key? key, required this.customerId}) : super(key: key);

  @override
  State<PhotoReport> createState() => _PhotoReportState();
}

class _PhotoReportState extends State<PhotoReport> {
  File? singleImage;

  final dio = Dio();

  final imagePicker = ImagePicker();

  List<File> images = [];
  List<int> photoTypeList = [];
  Response? response;
  Future<Response<dynamic>>? response1;

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      // images?.add(image);

      final imageTemporary = File(image.path);
      images.add(imageTemporary);
      photoTypeList.add(selectedPhotoType);

      setState(() {
        this.singleImage = imageTemporary;
      });

      for (int i = 0; i < images.length; i++) {
        print('@@@@@@@@@@@@@@@@${images[i].path}');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  final _prefs = SharedPreferences.getInstance();
  final List<String> photoTypes = ['Полка', 'Фасад', 'ФТО', 'Конкурент товар'];
  int selectedPhotoType = 0;

  Future putDataRequest(File? file, int customerId, int type) async {
    var box = Hive.box<FotoHiveModel>('foto_model');

    String fileName = file!.path.split('/').last;
    final prefs = await _prefs;
    final String? token = prefs.getString('token');

    try {
      for (int i = 0; i < images.length; i++) {
        FormData formData = FormData.fromMap({
          'id': customerId,
          'image': await MultipartFile.fromFile(
            images[i].path,
            // filename: fileName,
            // contentType: MediaType("image", fileName.split(".").last),
          ),
          'type': photoTypeList[i],
        });
        response = await dio
            .post(
          media_url + photoReportUrl,
          data: formData,
          options: Options(
            method: 'POST',
            headers: <String, String>{"Authorization": "Bearer ${token}"},
            responseType: ResponseType.json,
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            },
          ),
        )
            .timeout(Duration(seconds: 20), onTimeout: () async {
          var fotoModel = FotoHiveModel(
              type: photoTypeList[i], images: images[i].path, id: customerId);
          box.add(fotoModel);
          var n = box.getAt(i);
          print(n?.images);
          Fluttertoast.showToast(
              msg: "Hisobot tugatilmadi!",

              ///
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black45,
              textColor: Colors.white,
              fontSize: 16.0);
          Navigator.pop(context);

          return response1!;
        }).then((response) {
          if (response.statusCode == 200) {
            if (box.isNotEmpty) {
              box.deleteAt(i);
              images.removeAt(i);
              print(box.length);
            }
            Fluttertoast.showToast(
                msg: "Hisobot muvaffaqiyatli tugatildi!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.black45,
                textColor: Colors.white,
                fontSize: 16.0);
            Navigator.pop(context);
            // return;
          }
          print('Data ************${response.data}');
          print('Response------------>>$response');
        }).catchError((error) => print('Error-------->>$error'));
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.cancel_outlined,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Mening buyurtmalarim',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 16),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Sizda hali buyurtmalar yo\'q',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Foto hisobot',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 6),
            singleImage == null
                ? Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Siz hali hech qanday rasm olmadinigiz',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                : Container(
                    height: MediaQuery.of(context).size.height / 1.85,
                    child: GridView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: 10, right: 10),
                      itemCount: images.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20),
                      itemBuilder: (context, index) => Stack(
                        clipBehavior: Clip.none,
                        fit: StackFit.expand,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            child: Image.file(File(images[index].path),
                                fit: BoxFit.cover),
                          ),
                          Align(
                            alignment: const Alignment(1.35, -1.35),
                            child: InkWell(
                              onTap: () {
                                images.removeAt(index);
                                setState(() {});
                              },
                              child: SvgPicture.asset(
                                "assets/ic_red_close.svg",
                                width: 30,
                                height: 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
            SizedBox(height: 16),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(
                    height: 3,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        constraints: BoxConstraints(),
                        onPressed: () {
                          CustomCameraDialog.show(
                            context,
                            callback: (value, type) {
                              images.add(value);
                              photoTypeList.add(type);
                              this.singleImage = value;
                              setState(() {});
                            },
                          );
                          // showDialog(
                          //   context: context,
                          //   builder: (_) {
                          //     return AlertDialog(
                          //       title: Text('Fotosurat turini tanlang:'),
                          //       content: Column(
                          //         mainAxisSize: MainAxisSize.min,
                          //         crossAxisAlignment: CrossAxisAlignment.start,
                          //         children: photoTypes
                          //             .map(
                          //               (type) => InkWell(
                          //                 onTap: () {
                          //                   for (int i = 0;
                          //                       i < photoTypes.length;
                          //                       i++) {
                          //                     if (type == photoTypes[i]) {
                          //                       selectedPhotoType = i;
                          //                     }
                          //                   }
                          //
                          //                   pickImage(ImageSource.camera);
                          //                   if (singleImage != null &&
                          //                       images!.isNotEmpty) {
                          //                     Navigator.of(context).pop();
                          //                   }
                          //                 },
                          //                 child: Container(
                          //                   margin: EdgeInsets.all(4),
                          //                   padding: EdgeInsets.all(4),
                          //                   child: Text(type.toString()),
                          //                 ),
                          //               ),
                          //             )
                          //             .toList(),
                          //       ),
                          //     );
                          //   },
                          // );
                        },
                        icon: Icon(Icons.camera_alt),
                      ),
                      Text('Surat'),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (images.isNotEmpty) {
                        images.forEach((element) {
                          putDataRequest(element, widget.customerId,
                              photoTypeList[images.indexOf(element)]);
                          print(
                            'ADDED PHOTO :${element}\nID : ${widget.customerId}\nPHOTO TYPE : ${photoTypeList[images.indexOf(element)]}',
                          );
                        });
                      } else {
                        Fluttertoast.showToast(
                            msg: "Rasm tanlanmagan!",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black45,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                      // print(selectedPhotoType);
                    },
                    child: Center(
                      child: Text('Hisobotni tugatish'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
