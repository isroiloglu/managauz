import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/login.dart';



Future<void> logout(context) async{
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final SharedPreferences prefs = await _prefs;
  await prefs.remove('token');
  await prefs.setBool('loginned', false);
  Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (BuildContext context) =>
          const Login()));
}