// To parse this JSON data, do
//
//     final storyImage = storyImageFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class MyStoryImage {
  MyStoryImage({
    required this.id,
    required this.storyId,
    required this.customerId,
    required this.link,
  });

  int id;
  int storyId;
  int customerId;
  String link;

  factory MyStoryImage.fromJson(String str) => MyStoryImage.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MyStoryImage.fromMap(Map<String, dynamic> json) => MyStoryImage(
    id: json["id"],
    storyId: json["story_id"],
    customerId: json["customer_id"],
    link: json["link"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "story_id": storyId,
    "customer_id": customerId,
    "link": link,
  };
}
