// To parse this JSON data, do
//
//     final mainApi = mainApiFromJson(jsonString);

import 'dart:convert';

import 'package:manageuz/models/product.dart';
import 'package:manageuz/models/zakaz.dart';

MainApi mainApiFromJson(String str) => MainApi.fromJson(jsonDecode(str));

String mainApiToJson(MainApi data) => json.encode(data.toJson());

class MainApi {
  MainApi({
    required this.user,
    required this.zakazlar,
    this.oyliksumma,
    this.plan,
    this.soni,
    required this.skladlar,
    required this.prCategory,
    required this.tovarlar,
    required this.customs,
    required this.categories,
    required this.productcategories,
  });

  User user;
  List<Zakaz> zakazlar;
  int? oyliksumma;
  int? plan;
  int? soni;
  List<Skladlar> skladlar;
  List<Productcategory> prCategory;
  List<Tovarlar> tovarlar;
  List<Custom> customs;
  List<Category> categories;
  List<Productcategory> productcategories;

  factory MainApi.fromJson(Map<String, dynamic> json) => MainApi(
        user: User.fromJson(json["user"]),
        zakazlar: List<Zakaz>.from(json["zakazlar"].map((x) => Zakaz.fromJson(x))),
        oyliksumma: json["oyliksumma"],
        plan: json["plan"],
        soni: json["soni"],
        skladlar: List<Skladlar>.from(
            json["skladlar"].map((x) => Skladlar.fromJson(x))),
        prCategory: List<Productcategory>.from(
            json["productcategories"].map((x) => Productcategory.fromJson(x))),
        tovarlar: List<Tovarlar>.from(
            json["tovarlar"].map((x) => Tovarlar.fromJson(x))),
        customs:
            List<Custom>.from(json["customs"].map((x) => Custom.fromJson(x))),
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
        productcategories: List<Productcategory>.from(
            json["productcategories"].map((x) => Productcategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "zakazlar": List<dynamic>.from(zakazlar.map((x) => x)),
        "oyliksumma": oyliksumma,
        "plan": plan,
        "soni": soni,
        "skladlar": List<dynamic>.from(skladlar.map((x) => x.toJson())),
        "tovarlar": List<dynamic>.from(tovarlar.map((x) => x.toJson())),
        "customs": List<dynamic>.from(customs.map((x) => x.toJson())),
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
        "productcategories":
            List<dynamic>.from(productcategories.map((x) => x.toJson())),
      };
}

class Category {
  Category({
    required this.name,
    required this.id,
  });

  String name;
  int id;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
      };
}

class Custom {
  Custom({
    required this.id,
    required this.ism,
    required this.fam,
    this.daraja,
    this.balans,
    this.tel,
    this.address,
    this.iframe,
    required this.category,
  });

  int id;
  String ism;
  String fam;
  int? daraja;
  int? balans;
  int? tel;
  String? address;
  String? iframe;
  int? category;

  factory Custom.fromJson(Map<String, dynamic> json) => Custom(
        id: json["id"],
        ism: json["ism"],
        fam: json["fam"],
        daraja: json["daraja"],
        balans: json["balans"],
        tel: json["tel"] == null ? null : json["tel"],
        address: json["address"] == null ? null : json["address"],
        iframe: json["iframe"] == null ? null : json["iframe"],
        category: json["category"] == null ? null : json["category"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ism": ism,
        "fam": fam,
        "daraja": daraja,
        "balans": balans,
        "tel": tel == null ? null : tel,
        "address": address == null ? null : address,
        "iframe": iframe == null ? null : iframe,
        "category": category,
      };
}

class Productcategory {
  Productcategory({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory Productcategory.fromJson(Map<String, dynamic> json) =>
      Productcategory(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Skladlar {
  Skladlar({
    required this.nomi,
    required this.id,
  });

  String nomi;
  int id;

  factory Skladlar.fromJson(Map<String, dynamic> json) => Skladlar(
        nomi: json["Nomi"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "Nomi": nomi,
        "id": id,
      };
}

class Tovarlar {
  Tovarlar({
    required this.nomi,
    required this.id,
    required this.narxi,
    this.optomNarxi,
    this.karobka,
    this.soni,
    this.sklad,
    this.skidka1,
    this.skidka2,
    this.category,
  });

  String? nomi;
  int? id;
  int? narxi;
  int? optomNarxi;
  int? karobka;
  int? soni;
  int? sklad;
  int? skidka1;
  int? skidka2;
  int? category;

  factory Tovarlar.fromJson(Map<String, dynamic> json) => Tovarlar(
        nomi: json["Nomi"],
        id: json["id"],
        narxi: json["narxi"],
        optomNarxi: json["optom_narxi"],
        karobka: json["karobka"],
        soni: json["soni"],
        sklad: json["sklad"],
        skidka1: json["skidka1"],
        skidka2: json["skidka2"],
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
        "nomi": nomi,
        "id": id,
        "narxi": narxi,
        "optom_narxi": optomNarxi,
        "karobka": karobka,
        "soni": soni,
        "sklad": sklad,
        "skidka1": skidka1,
        "skidka2": skidka2,
      };
}

class User {
  User({
    required this.id,
    required this.ism,
    required this.fam,
    required this.login,
    required this.parol,
    this.daraja,
    this.izoh,
    this.tel,
    this.lang,
    this.balans,
    this.rememberToken,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String ism;
  String fam;
  String login;
  String parol;
  int? daraja;
  String? izoh;
  int? tel;
  dynamic? lang;
  int? balans;
  dynamic? rememberToken;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        ism: json["ism"],
        fam: json["fam"],
        login: json["login"],
        parol: json["parol"],
        daraja: json["daraja"],
        izoh: json["izoh"],
        tel: json["tel"],
        lang: json["lang"],
        balans: json["balans"],
        rememberToken: json["remember_token"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ism": ism,
        "fam": fam,
        "login": login,
        "parol": parol,
        "daraja": daraja,
        "izoh": izoh,
        "tel": tel,
        "lang": lang,
        "balans": balans,
        "remember_token": rememberToken,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
