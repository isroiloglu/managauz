import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:manageuz/constants.dart';
import 'package:manageuz/models/main_model.dart';
import 'package:manageuz/models/token_model.dart';
import 'package:manageuz/providers/get_main_data_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier{
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool loginError = false;
  bool loginLoading = false;
  String? username, password;

  LoginProvider({required this.loginError, required this.loginLoading, this.username, this.password});

  void unError(){
    loginError = false;
    notifyListeners();
  }

  void updateUsername(String? user_name){
    username = user_name;
    notifyListeners();
    unError();
  }

  void updatePassword(String? password_changing){
    password = password_changing;
    notifyListeners();
    unError();
  }

  Future login() async{
    loginLoading = true;
    notifyListeners();
    final SharedPreferences prefs = await _prefs;
      var url = Uri.parse('$base_url/api/agent/login');
      var response = await http.post(url, body: {'login': username, 'password': password});
      if(response.statusCode == 422){
        loginError= true;
        notifyListeners();
      }
      if(response.statusCode == 200){
        var tokendata = tokenFromJson(response.body);
        await prefs.setString('token', tokendata.token);
        await prefs.setBool('loginned', true);
        loginLoading = false;
        await MainApiProvider(hududlar: [Category(name: "Barcha Hududlar", id: -1)]).getData();
        notifyListeners();
        return 'foward';
      }else{
        loginLoading = false;
        notifyListeners();
        return 'stay';
      }
  }

}