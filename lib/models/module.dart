// ignore_for_file: non_constant_identifier_names

import 'dart:io';

class Module {
  int langue_id;
  int? module_id;
  String module_name;
  String? module_image;
  double module_price;
  File? image_module;

  Module({
    this.module_id,
    required this.langue_id,
    required this.module_name,
    this.module_image,
    required this.module_price,
    this.image_module,
  });

  Map<String, dynamic> toMap() => {
        'langue_id': langue_id,
        'module_id': module_id,
        'module_title': module_name,
        'module_image': module_image,
        'module_prix': module_price,
      };

  Map<String, dynamic> toAPI() => {
        'langue_id': langue_id,
        'module_title': module_name,
        if (image_module != null) 'module_image': image_module,
        'module_prix': module_price,
      };

  factory Module.fromMap(data) => Module(
        langue_id: data['langue_id'],
        module_name: data['module_title'],
        module_price: data['module_prix'] * 1.0,
        module_id: data['module_id'],
        module_image: data['module_image'],
      );
}
