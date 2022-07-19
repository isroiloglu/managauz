import 'package:manageuz/models/main_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import 'package:http/http.dart' as http;



Future getMainData() async{
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final SharedPreferences prefs = await _prefs;
  var token = prefs.getString('token');
  var url = Uri.parse('$base_url/api/agent/user');
  var response = await http.get(url, headers: {'Authorization': 'Bearer $token'});

  if(response.statusCode == 200){
    await prefs.setString('maindata', response.body);
    return mainApiFromJson(response.body);
  }else{
    return 'problem';
  }
}