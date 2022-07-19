/// id : 41108
/// izoh : null
/// summa : 404000
/// ism : "Naziraka"
/// fam : "Mamajonov"

class Zakaz {
  Zakaz({
    this.id,
    this.izoh,
    this.summa,
    this.ism,
    this.fam,
  });

  Zakaz.fromJson(dynamic json) {
    id = json['id'];
    izoh = json['izoh'];
    summa = json['summa'];
    ism = json['ism'];
    fam = json['fam'];
  }

  int? id;
  dynamic izoh;
  int? summa;
  String? ism;
  String? fam;

  Zakaz copyWith({
    int? id,
    dynamic izoh,
    int? summa,
    String? ism,
    String? fam,
  }) =>
      Zakaz(
        id: id ?? this.id,
        izoh: izoh ?? this.izoh,
        summa: summa ?? this.summa,
        ism: ism ?? this.ism,
        fam: fam ?? this.fam,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['izoh'] = izoh;
    map['summa'] = summa;
    map['ism'] = ism;
    map['fam'] = fam;
    return map;
  }
}
