import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'custom_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import '../models/main_model.dart';
import '../widgets/nav_drawer.dart';

class ClientsListView extends StatefulWidget {
  ClientsListView({Key? key}) : super(key: key);

  @override
  State<ClientsListView> createState() => _ClientsListViewState();
}

class _ClientsListViewState extends State<ClientsListView> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late List customs = [];

  Future<void> fetchData() async {
    var url = Uri.parse('$base_url/api/agent/user');
    final SharedPreferences prefs = await _prefs;
    final String? token = prefs.getString('token');
    final response = await http.get(
      url,
      headers: <String, String>{
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    final Map<String, dynamic> body = json.decode(response.body);
    MainApi mainApi = MainApi.fromJson(body);
    customs.addAll(mainApi.customs);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar:
          AppBar(centerTitle: true, title: const Text("Klientlar roʻyxati")),
      body: Container(
        child: ListView.builder(
          itemCount: customs.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: ListTile(
                title: Text('${customs[index].fam} ${customs[index].ism}'),
                subtitle: Text(
                  '${customs[index].balans}',
                ),
                leading: const CircleAvatar(
                  child: Text('rasm'),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CustomView(
                        custom: customs[index],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
