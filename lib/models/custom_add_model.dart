// To parse this JSON data, do
//
//     final customerAdd = customerAddFromJson(jsonString);

import 'dart:convert';

CustomerAdd customerAddFromJson(String str) => CustomerAdd.fromJson(json.decode(str));

String customerAddToJson(CustomerAdd data) => json.encode(data.toJson());

class CustomerAdd {
  CustomerAdd({
    required this.ism,
    required this.fam,
    required this.balans,
    required this.turi,
    required this.telegram,
    required this.tel,
    required this.lang,
    required this.lat,
    this.address,
  });

  String ism;
  String fam;
  int balans;
  int turi;
  int telegram;
  int tel;
  double lang;
  double lat;
  String? address;

  factory CustomerAdd.fromJson(Map<String, dynamic> json) => CustomerAdd(
    ism: json["ism"],
    fam: json["fam"],
    balans: json["balans"],
    turi: json["turi"],
    telegram: json["telegram"],
    tel: json["tel"],
    lang: json["lang"].toDouble(),
    lat: json["lat"].toDouble(),
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "ism": ism,
    "fam": fam,
    "balans": balans,
    "turi": turi,
    "telegram": telegram,
    "tel": tel,
    "lang": lang,
    "lat": lat,
    "address": address,
  };
}
