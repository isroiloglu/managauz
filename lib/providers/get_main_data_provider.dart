import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:manageuz/models/main_model.dart';
import 'package:manageuz/models/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import '../models/product_model.dart';

class MainApiProvider extends ChangeNotifier {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  MainApi? data;
  List<Category> hududlar;

  Product? product;
  List<Productcategory> prCategory = [];

  List<Custom> oldCustomers = [];
  double allCost = 0;
  int active_hudud_id = -1;
  int active_sklad_id = -1;
  int active_client_id = -1;
  int active_kt_id = -1;
  int userType = 0;
  List<Custom> customers = [];
  List<Skladlar> skladlar = [];
  List<Tovarlar> tovarlar = [];
  String _searchString = "";

  MainApiProvider({this.data, required this.hududlar});

  Future<String> getData() async {
    final SharedPreferences prefs = await _prefs;
    String? datajson = prefs.getString('maindata');

    data = datajson != null ? mainApiFromJson(datajson) : basemainapi;
    List<Category> a = [Category(name: "Barcha Hududlar", id: -1)];
    List<Category> categories = data!.categories;
    a.addAll(categories);
    hududlar = a;
    List<Productcategory> b = [
      Productcategory(name: "Barcha Maxsulotlar", id: -1)
    ];
    List<Productcategory> pr = data!.prCategory;
    b.addAll(pr);
    prCategory = b;
    skladlar = data!.skladlar;
    tovarlar = data!.tovarlar;

    notifyListeners();
    var token = prefs.getString('token');
    var url = Uri.parse('$base_url/api/agent/user');
    var response =
    await http.get(url, headers: {'Authorization': 'Bearer $token'});

    print('token buL ${token}');
    if (response.statusCode == 200) {
      await prefs.setString('maindata', response.body);
      data = mainApiFromJson(response.body);
      List<Category> a = [Category(name: "Barcha Hududlar", id: -1)];
      List<Category> categories = data!.categories;
      a.addAll(categories);
      hududlar = a;
      List<Productcategory> b = [
        Productcategory(name: "Barcha Maxsulotlar", id: -1)
      ];
      List<Productcategory> pr = data!.prCategory;
      b.addAll(pr);
      userType = data!.user.daraja!;
      prCategory = b;
      customers = data!.customs;
      oldCustomers = data!.customs;
      tovarlar = data!.tovarlar;
      skladlar = data!.skladlar;
      notifyListeners();
      return 'success';
    } else {
      return 'problem';
    }
  }

  Future<void> postProduct(Product product, BuildContext context) async {
    final SharedPreferences prefs = await _prefs;

    var token = prefs.getString('token');

    Map<String, String> param = {
      "id": product.id.toString(),
    };
    for (int i = 0; i < (product.ztovarlar?.length ?? 0); i++) {
      param["ztid${i + 1}"] = product.ztovarlar?[i].id.toString() ?? '0';
      param["zsoni${i + 1}"] = product.ztovarlar?[i].soni.toString() ?? '0';
    }
    var url = Uri.parse('$base_url/api/agent/editzakazcode');
    var response = await http.post(url,
        headers: {'Authorization': 'Bearer $token'}, body: param);
    if (response.statusCode == 200) {
      Navigator.pop(context);
      notifyListeners();
    }
  }

  Future<Product?> getProducts(id) async {
    print('bu id ${id}');

    final SharedPreferences prefs = await _prefs;
    String? datajson = prefs.getString('productData');
    print('tu json: $datajson');

    product =
    datajson != null ? Product.fromJson(jsonDecode((datajson))) : null;

    var token = prefs.getString('token');
    var url = Uri.parse('$base_url/api/agent/editzakaz?id=$id');
    var response =
    await http.post(url, headers: {'Authorization': 'Bearer $token'});
    print('data bu ${response.body}');
    if (response.statusCode == 200) {
      await prefs.setString('productData', response.body);
      product = Product.fromJson(jsonDecode(response.body));

      notifyListeners();
    }
    return null;
  }

  changeHudud(int id) {
    active_hudud_id = id;

    if (id != -1) {
      List<Custom> a = data!.customs;
      customers = a.where((element) => element.category == id).toList();
    } else {
      List<Custom> a = data!.customs;
      customers = a;
      oldCustomers = a;
    }
    notifyListeners();
  }

  changeSklad(int id) {
    active_sklad_id = id;
    notifyListeners();
  }

  UnmodifiableListView<Custom> get customItems =>
      _searchString.isEmpty
          ? UnmodifiableListView(customers)
          : UnmodifiableListView(customers.where((custom) {
        final titleLower = "${custom.ism.toLowerCase()} ${custom.fam.toLowerCase()}";
        final searchLower = _searchString.toLowerCase();
        return titleLower.contains(searchLower);
      }));

  void changeSearchString(String searchString) {
    _searchString = searchString;
    print(_searchString);
    notifyListeners();
  }

  changeKlient(int id) {
    active_client_id = id;
    notifyListeners();
  }

  changeKategory(int id) {
    active_kt_id = id;
    if (id != -1) {
      List<Tovarlar> a = data!.tovarlar
          .where((element) => element.sklad == active_sklad_id)
          .toList();
      tovarlar = a.where((element) => element.category == id).toList();
    } else {
      List<Tovarlar> a = data!.tovarlar
          .where((element) => element.sklad == active_sklad_id)
          .toList();
      tovarlar = a;
    }
    notifyListeners();
  }

  changeSearch(List<Tovarlar> tovar, String txt) {
    tovar
        .where((food) => food.nomi!.toLowerCase().contains(txt.toLowerCase()))
        .toList();
    print(tovar);
    notifyListeners();
  }

  changeAllCost(List<TextEditingController> listBloc,
      List<TextEditingController> listCount, List<Tovarlar> tovarlar) {
    double count = 0;
    double karobka = 0;
    double narx = 0;
    allCost = 0;
    for (int i = 0; i < tovarlar.length; i++) {
      narx = double.parse(
          (userType == 1 ? tovarlar[i].narxi : tovarlar[i].optomNarxi)
              .toString());
      count = (double.parse(listCount[i].text == "" ? "0" : listCount[i].text));
      karobka = (double.parse(listBloc[i].text == "" ? "0" : listBloc[i].text) *
          double.parse((tovarlar[i].karobka!).toString()));
      if (tovarlar[i].soni! < (count + karobka)) {
        listCount[i].text = "";
        listBloc[i].text = "";
        Fluttertoast.showToast(
            msg: "Tovar miqdoridan ortiq urib bo'lmaydi!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black45,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        allCost = allCost + count * narx + (karobka * narx);
      }
    }
    print(allCost);
    notifyListeners();
  }

  sendData(List<TextEditingController> listBloc,
      List<TextEditingController> listCount,
      List<Tovarlar> tovarlar,
      BuildContext context) async {
    final SharedPreferences prefs = await _prefs;
    double count = 0;
    double karobka = 0;
    int countOrder = 0;
    List<ProductModel> productList = [];
    Map<String, String> param = {
      "kilent": active_client_id.toString(),
      "sklad": active_sklad_id.toString()
    };
    for (int i = 0; i < tovarlar.length; i++) {
      count = (double.parse(listCount[i].text == "" ? "0" : listCount[i].text));
      karobka = (double.parse(listBloc[i].text == "" ? "0" : listBloc[i].text) *
          double.parse((tovarlar[i].karobka!).toString()));
      if ((count + karobka) > 0) {
        param["id${i + 1}"] = tovarlar[i].id.toString();
        param["soni${i + 1}"] = (karobka + count).toString();
        countOrder++;
      }
    }
    param["zakazsoni"] = countOrder.toString();
    if (countOrder > 0) {
      var token = prefs.getString('token');
      var url = Uri.parse('$base_url/api/agent/booked');
      var response = await http
          .post(url, body: param, headers: {'Authorization': 'Bearer $token'});
      if (response.statusCode == 200) {
        active_client_id = 0;
        Fluttertoast.showToast(
            msg: "Malumotlar saqlandi!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black45,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      } else {
        Fluttertoast.showToast(
            msg: "Malumotlar yuklanishda xatolik yuz berdi!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black45,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } else {
      Fluttertoast.showToast(
          msg: "Siz maxsulot buyurtma qilmagansiz!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black45,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    notifyListeners();
    getData();
  }
}
