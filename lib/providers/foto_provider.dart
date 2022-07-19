import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:manageuz/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../models/main_model.dart';

class FotoApiProvider extends ChangeNotifier {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  List<Custom> customers = [];
  List<Custom> oldCustomers = [];
  String _searchString = "";
  MainApi? data;

  Future<String> getData() async {
    final SharedPreferences prefs = await _prefs;
    String? datajson = prefs.getString('maindata');

    data = datajson != null ? mainApiFromJson(datajson) : basemainapi;
    notifyListeners();
    var token = prefs.getString('token');
    var url = Uri.parse('$base_url/api/agent/user');
    var response =
        await http.get(url, headers: {'Authorization': 'Bearer $token'});

    print('token buL ${token}');
    if (response.statusCode == 200) {
      await prefs.setString('maindata', response.body);
      data = mainApiFromJson(response.body);
      customers = data!.customs;
      oldCustomers = data!.customs;
      notifyListeners();
      return 'success';
    } else {
      return 'problem';
    }
  }

  UnmodifiableListView<Custom> get customItems => _searchString.isEmpty
      ? UnmodifiableListView(customers)
      : UnmodifiableListView(customers.where((custom) {
          String titleLower =
              "${custom.ism.toLowerCase()} ${custom.fam.toLowerCase()}";
          String searchLower = _searchString.toLowerCase();
          return titleLower.contains(searchLower);
        }));

  void changeSearchString(String searchString) {
    _searchString = searchString;
    print(_searchString);
    notifyListeners();
  }
}
