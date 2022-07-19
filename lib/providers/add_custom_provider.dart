import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import '../screens/clients_list_view.dart';

class AddCustomProvider extends ChangeNotifier {
  // List<RegisterItem> RegisterItems = [
  //   RegisterItem(title: 'ism', label: 'Ism', error: '', value: ''),
  //   RegisterItem(title: 'fam', label: 'Familya', error: '', value: ''),
  //   RegisterItem(title: 'balans', label: 'Balans', error: ''),
  // ];

  // onChange(name, value) {
  //   if (name == "turi") {}
  // }

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  final TextEditingController name = TextEditingController();
  final TextEditingController surname = TextEditingController();
  final TextEditingController balance = TextEditingController();
  // int type = -1;
  final TextEditingController telegram = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController lang = TextEditingController();
  final TextEditingController lat = TextEditingController();
  final TextEditingController address = TextEditingController();

  Future addCustom(int type, BuildContext context) async {
    notifyListeners();
    var url = Uri.parse('$base_url/api/agent/customadd');
    final SharedPreferences prefs = await _prefs;
    final String? token = prefs.getString('token');

    var response = await http.post(
      url,
      headers: <String, String>{
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'ism': name.text,
        'fam': surname.text,
        'balans': int.parse(balance.text),
        'turi': type,
        'telegram': int.parse(telegram.text),
        'tel': int.parse(phone.text),
        'lang': int.parse(lang.text),
        'lat': int.parse(lat.text),
        'address': address.text,
      }),
    );

    if (response.statusCode == 422) {
      print('xato');
      notifyListeners();
    }
    if (response.statusCode == 200) {
      notifyListeners();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => ClientsListView(),
        ),
      );
      name.clear();
      surname.clear();
      balance.clear();
      type = 1;
      telegram.clear();
      phone.clear();
      lang.clear();
      lat.clear();
      address.clear();
      return 'foward';
    } else {
      // loginLoading = false;
      notifyListeners();
      return 'stay';
    }
  }
}
