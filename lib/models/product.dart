import 'package:manageuz/models/main_model.dart';

/// ztovarlar : [{"nomi":"MEGA TUZLIK 100gr","soni":40,"summa":6050,"zsoni":573,"id":13931,"jsoni":7152},{"nomi":"MEGA TUZSIZ 100gr","soni":30,"summa":6050,"zsoni":574,"id":13932,"jsoni":3878}]
/// tovarlar : [{"id":573,"nomi":"MEGA TUZLIK 100gr","soni":7152,"narxi":5900,"optom_narxi":5850},{"id":574,"nomi":"MEGA TUZSIZ 100gr","soni":3878,"narxi":5900,"optom_narxi":5850},{"id":575,"nomi":"MEGA TUZLIK  kg","soni":63,"narxi":32000,"optom_narxi":30000},{"id":576,"nomi":"MEGA TUZSIZ kg","soni":24,"narxi":32000,"optom_narxi":30000},{"id":577,"nomi":"MEGA OK TUZLIK 100gr","soni":0,"narxi":2600,"optom_narxi":2500},{"id":578,"nomi":"MEGA QURT sht","soni":0,"narxi":405,"optom_narxi":395},{"id":599,"nomi":"MEGA QOVOQ tuzlik","soni":0,"narxi":6000,"optom_narxi":5500},{"id":600,"nomi":"MEGA QOVOQ tuzsiz","soni":0,"narxi":6000,"optom_narxi":5500},{"id":601,"nomi":"MEGA TIME TUZLIK 90gr","soni":1555,"narxi":4000,"optom_narxi":3900},{"id":602,"nomi":"MEGA TIME TUZSIZ 90gr","soni":2811,"narxi":4000,"optom_narxi":3900},{"id":603,"nomi":"MEGA YER YONG'OQ 50gr","soni":300,"narxi":2600,"optom_narxi":2550},{"id":622,"nomi":"IMMUN-KO","soni":0,"narxi":183,"optom_narxi":183},{"id":623,"nomi":"\"\r\n    MEGA qurt 46 gr","soni":138,"narxi":4400,"optom_narxi":4300},{"id":756,"nomi":"PANDA 500GR","soni":0,"narxi":8300,"optom_narxi":8000},{"id":757,"nomi":"LUNA  500gr","soni":0,"narxi":8300,"optom_narxi":8000},{"id":758,"nomi":"BRIKET 500gr","soni":0,"narxi":8300,"optom_narxi":8000},{"id":759,"nomi":"SNEJINKA 400gr","soni":0,"narxi":7500,"optom_narxi":7000},{"id":760,"nomi":"SNEJINKA KG","soni":0,"narxi":14000,"optom_narxi":13500},{"id":761,"nomi":"ZVYOZDOCHKA KG","soni":0,"narxi":13500,"optom_narxi":13000},{"id":762,"nomi":"KEREMAS","soni":0,"narxi":4350,"optom_narxi":4250},{"id":895,"nomi":"Dirol   yalpizl","soni":0,"narxi":420,"optom_narxi":420},{"id":896,"nomi":"Dirol tarvuz qovun","soni":0,"narxi":420,"optom_narxi":420},{"id":1953,"nomi":"Mega qurt 30 gr","soni":0,"narxi":3400,"optom_narxi":3300},{"id":2227,"nomi":"MEGA 20gr ok","soni":0,"narxi":420,"optom_narxi":400},{"id":2773,"nomi":"MEGA TUZLIK 200gr","soni":345,"narxi":11600,"optom_narxi":11500},{"id":2774,"nomi":"MEGA TUZSIZ 200gr","soni":216,"narxi":11600,"optom_narxi":11500},{"id":2997,"nomi":"Xandom pista 30gr","soni":0,"narxi":9000,"optom_narxi":8800},{"id":3531,"nomi":"slays salyami","soni":0,"narxi":35000,"optom_narxi":34000},{"id":3532,"nomi":"slays sir","soni":1,"narxi":35000,"optom_narxi":34000},{"id":3533,"nomi":"slays kalbasa","soni":0,"narxi":35000,"optom_narxi":34000},{"id":3534,"nomi":"slays smetana","soni":0,"narxi":35000,"optom_narxi":34000},{"id":3535,"nomi":"slays achiq","soni":0,"narxi":35000,"optom_narxi":34000},{"id":3536,"nomi":"slays kabob","soni":0,"narxi":35000,"optom_narxi":34000},{"id":3537,"nomi":"slays qazi","soni":36,"narxi":35000,"optom_narxi":34000},{"id":3538,"nomi":"slays tuzlik","soni":21,"narxi":35000,"optom_narxi":34000},{"id":3816,"nomi":"Bodom 40gr","soni":69,"narxi":9100,"optom_narxi":8900}]

class Product {
  Product({
    this.id,
    this.ztovarlar,
    this.tovarlar,
  });

  Product.fromJson(dynamic json) {

    if (json['ztovarlar'] != null) {
      ztovarlar = [];
      json['ztovarlar'].forEach((v) {
        ztovarlar?.add(Ztovarlar.fromJson(v));
      });
    }
    id = json['id'];
    if (json['tovarlar'] != null) {
      tovarlar = [];
      json['tovarlar'].forEach((v) {
        tovarlar?.add(Tovarlar.fromJson(v));
      });
    }
  }

  List<Ztovarlar>? ztovarlar;
  List<Tovarlar>? tovarlar;
  int? id;
  Product copyWith({
    List<Ztovarlar>? ztovarlar,
    List<Tovarlar>? tovarlar,
    int? id,
  }) =>
      Product(
        ztovarlar: ztovarlar ?? this.ztovarlar,
        tovarlar: tovarlar ?? this.tovarlar,
        id: id ?? this.id,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (ztovarlar != null) {
      map['ztovarlar'] = ztovarlar?.map((v) => v.toJson()).toList();
    }
    if (tovarlar != null) {
      map['tovarlar'] = tovarlar?.map((v) => v.toJson()).toList();
    }
    map['id'] = id;
    return map;
  }
}

/// id : 573
/// nomi : "MEGA TUZLIK 100gr"
/// soni : 7152
/// narxi : 5900
/// optom_narxi : 5850


/// nomi : "MEGA TUZLIK 100gr"
/// soni : 40
/// summa : 6050
/// zsoni : 573
/// id : 13931
/// jsoni : 7152

class Ztovarlar {
  Ztovarlar({
    this.nomi,
    this.soni,
    this.summa,
    this.zsoni,
    this.id,
    this.jsoni,
  });

  Ztovarlar.fromJson(dynamic json) {
    nomi = json['nomi'];
    soni = json['soni'];
    summa = json['summa'];
    zsoni = json['zsoni'];
    id = json['id'];
    jsoni = json['jsoni'];
  }

  String? nomi;
  int? soni;
  int? summa;
  int? zsoni;
  int? id;
  int? jsoni;

  Ztovarlar copyWith({
    String? nomi,
    int? soni,
    int? summa,
    int? zsoni,
    int? id,
    int? jsoni,
  }) =>
      Ztovarlar(
        nomi: nomi ?? this.nomi,
        soni: soni ?? this.soni,
        summa: summa ?? this.summa,
        zsoni: zsoni ?? this.zsoni,
        id: id ?? this.id,
        jsoni: jsoni ?? this.jsoni,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['nomi'] = nomi;
    map['soni'] = soni;
    map['summa'] = summa;
    map['zsoni'] = zsoni;
    map['id'] = id;
    map['jsoni'] = jsoni;
    return map;
  }
}
