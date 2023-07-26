// ignore_for_file: non_constant_identifier_names

import 'dart:io';

class Langue {
  int? langue_id;
  String langue_name;
  String? langue_image;
  String? langue_origine;
  File? image_lan;

  Langue({
    required this.langue_name,
    this.langue_id,
    this.langue_image,
    this.langue_origine,
    this.image_lan,
  });

  Map<String, dynamic> toMap() => {
        "langue_name": langue_name,
        "langue_image": langue_image,
        "langue_origine": langue_origine,
        "langue_id": langue_id,
      };

  Map<String, dynamic> toAPI() => {
        "langue_name": langue_name,
        if (image_lan != null) "langue_image": langue_image,
        "langue_origine": langue_origine,
        "langue_id": langue_id,
      };

  factory Langue.fromMap(data) => Langue(
        langue_name: data['langue_name'],
        langue_id: data['langue_id'],
        langue_image: data['langue_image'],
        langue_origine: data['langue_origine'],
      );
}
