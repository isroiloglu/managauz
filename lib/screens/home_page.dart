import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:manageuz/constants.dart';
import 'package:manageuz/models/main_model.dart';
import 'package:manageuz/providers/get_main_data_provider.dart';
import 'package:manageuz/screens/edit_page.dart';
import 'package:manageuz/widgets/nav_drawer.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/foto_hive_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MainApi? data;
  var box = Hive.box<FotoHiveModel>('foto_model');
  final dio = Dio();
  Response? response;
  final _prefs = SharedPreferences.getInstance();

  Future<Response<dynamic>>? response1;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    await Provider.of<MainApiProvider>(context, listen: false).getData();
    data = Provider.of<MainApiProvider>(context, listen: false).data;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Manage.uz',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: DataTable(
            horizontalMargin: 16,
            columnSpacing: 14,
            columns: const <DataColumn>[
              DataColumn(
                label: Text(
                  'ID',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              DataColumn(
                label: Text(
                  'Klient',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              DataColumn(
                label: Text(
                  'Summa',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              DataColumn(
                label: Text(
                  'Ko\'rish',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ],
            rows: List.generate(
              data?.zakazlar.length ?? 0,
              (index) => DataRow(
                cells: <DataCell>[
                  DataCell(Text((index + 1).toString())),
                  DataCell(Text((data?.zakazlar[index].fam.toString() ?? '') +
                      ' ' +
                      (data?.zakazlar[index].ism.toString() ?? ''))),
                  DataCell(Text(data?.zakazlar[index].summa.toString() ?? '')),
                  DataCell(
                    RaisedButton(
                      onPressed: () async {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => EditPage(
                                      data: data?.zakazlar[index],
                                    )));
                        fetchData();
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: Text(
                        "Ko'rish",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.blueAccent,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: ValueListenableBuilder<Box<FotoHiveModel>>(
        valueListenable: Hive.box<FotoHiveModel>('foto_model').listenable(),
        builder: (context, box, _) {
          return Visibility(
            visible: box.isNotEmpty,
            child: FloatingActionButton(
              child: Icon(Icons.refresh_outlined),
              onPressed: () async {
                final prefs = await _prefs;
                final String? token = prefs.getString('token');
                try {
                  for (int i = box.keys.first; i <= box.keys.last; i++) {
                    FormData formData = FormData.fromMap({
                      'id': box.get(i)?.id,
                      'image': await MultipartFile.fromFile(
                        box.get(i)?.images ?? '',
                      ),
                      'type': box.get(i)?.type,
                    });
                    response = await dio
                        .post(
                      media_url + photoReportUrl,
                      data: formData,
                      options: Options(
                        method: 'POST',
                        headers: <String, String>{
                          "Authorization": "Bearer ${token}"
                        },
                        responseType: ResponseType.json,
                        followRedirects: false,
                        validateStatus: (status) {
                          return status! < 500;
                        },
                      ),
                    )
                        .timeout(Duration(seconds: 20),
                            onTimeout: () async {
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
                          box.delete(box.keys.first);
                          setState(() {});
                          print(box.length);
                        } else if (box.isEmpty) {
                          Fluttertoast.showToast(
                              msg: "Muvaffaqiyatli yakunlandi!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black45,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                      }
                      print('Data ************${response.data}');
                      print('Response------------>>$response');
                    }).catchError((error) {
                      Fluttertoast.showToast(
                          msg: "Server xatoligi!",
                          toastLength: Toast.LENGTH_SHORT,
                          // gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black45,
                          textColor: Colors.white,
                          fontSize: 16.0);
                      print('Error-------->>$error');
                    });
                  }
                } catch (e) {
                  print(e.toString());
                }
              },
            ),
          );
        },
      ),
    );
  }
}
