// To parse this JSON data, do
//
//     final story = storyFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class Story {
  Story({
    required this.id,
    required this.publishBy,
    required this.image,
    required this.readed,
  });

  int id;
  int publishBy;
  String image;
  int readed;

  factory Story.fromJson(String str) => Story.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Story.fromMap(Map<String, dynamic> json) => Story(
    id: json["id"],
    publishBy: json["publish_by"],
    image: json["image"],
    readed: json["readed"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "publish_by": publishBy,
    "image": image,
    "readed": readed,
  };
}
