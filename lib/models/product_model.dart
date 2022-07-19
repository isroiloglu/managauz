class ProductModel {
  int? id;
  double? soni;

  ProductModel({this.id, this.soni});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    soni = json['soni'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['soni'] = this.soni;
    return data;
  }
}