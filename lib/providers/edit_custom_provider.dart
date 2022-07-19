import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import '../screens/clients_list_view.dart';

class EditCustomProvider extends ChangeNotifier {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  final TextEditingController name = TextEditingController();
  final TextEditingController surname = TextEditingController();
  // final TextEditingController balance = TextEditingController();
  // int type = -1;
  final TextEditingController telegram = TextEditingController();
  final TextEditingController phone = TextEditingController();
  // final TextEditingController lang = TextEditingController();
  // final TextEditingController lat = TextEditingController();
  // final TextEditingController address = TextEditingController();

  Future updateCustom(int id, BuildContext context) async {
    var url = Uri.parse('$base_url/api/agent/customedit');
    final SharedPreferences prefs = await _prefs;
    final String? token = prefs.getString('token');

    var response = await http.post(
      url,
      headers: <String, String>{
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id': id,
        'ism': name.text,
        'fam': surname.text,
        // 'balans': int.parse(balance.text),
        // 'turi': type,
        'telegram': int.parse(telegram.text),
        'tel': int.parse(phone.text),
        'lang': 0,
        'lat': 0,
        // 'adress': address.text,
      }),
    );

    if (response.statusCode == 422) {
      print('xato');
      notifyListeners();
    }
    if (response.statusCode == 200) {
      var count = 0;
      // Navigator.popUntil(context, (route) {
      //   return count++ == 2;
      // });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => ClientsListView(),
        ),
      );
      return 'foward';
    } else {
      // loginLoading = false;
      notifyListeners();
      return 'stay';
    }
  }
}
