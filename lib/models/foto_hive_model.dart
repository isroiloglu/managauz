import 'dart:io';

import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

part 'foto_hive_model.g.dart';

@HiveType(typeId: 1)
class FotoHiveModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? images;
  @HiveField(2)
  int? type;

  FotoHiveModel({
    this.id,
    this.images,
    this.type,
  });

  FotoHiveModel.fromJson(dynamic json) {
    id = json['id'];
    images = json['image'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['image'] = images;
    map['type'] = type;
    return map;
  }
}
