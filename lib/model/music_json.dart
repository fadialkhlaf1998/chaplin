// To parse this JSON data, do
//
//     final music = musicFromMap(jsonString);

import 'dart:convert';

class MusicJson {
  MusicJson({
    this.id,
    this.name,
    this.description,
    this.metaData,
    this.links,
  });

  int? id;
  String? name;
  String? description;
  List<MetaDatum>? metaData;
  Links? links;

  factory MusicJson.fromJson(String str) => MusicJson.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MusicJson.fromMap(Map<String, dynamic> json) => MusicJson(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    metaData: List<MetaDatum>.from(json["meta_data"].map((x) => MetaDatum.fromMap(x))),
    links: Links.fromMap(json["_links"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,

    "meta_data": List<dynamic>.from(metaData!.map((x) => x.toMap())),
    "_links": links!.toMap(),
  };
}

class Category {
  Category({
    this.id,
    this.name,
    this.slug,
  });

  int? id;
  String? name;
  String? slug;

  factory Category.fromJson(String str) => Category.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Category.fromMap(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "slug": slug,
  };
}

class Dimensions {
  Dimensions({
    this.length,
    this.width,
    this.height,
  });

  String? length;
  String? width;
  String? height;

  factory Dimensions.fromJson(String str) => Dimensions.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Dimensions.fromMap(Map<String, dynamic> json) => Dimensions(
    length: json["length"],
    width: json["width"],
    height: json["height"],
  );

  Map<String, dynamic> toMap() => {
    "length": length,
    "width": width,
    "height": height,
  };
}

class Links {
  Links({
    this.self,
    this.collection,
  });

  List<Collection>? self;
  List<Collection>? collection;

  factory Links.fromJson(String str) => Links.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Links.fromMap(Map<String, dynamic> json) => Links(
    self: List<Collection>.from(json["self"].map((x) => Collection.fromMap(x))),
    collection: List<Collection>.from(json["collection"].map((x) => Collection.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "self": List<dynamic>.from(self!.map((x) => x.toMap())),
    "collection": List<dynamic>.from(collection!.map((x) => x.toMap())),
  };
}

class Collection {
  Collection({
    this.href,
  });

  String? href;

  factory Collection.fromJson(String str) => Collection.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Collection.fromMap(Map<String, dynamic> json) => Collection(
    href: json["href"],
  );

  Map<String, dynamic> toMap() => {
    "href": href,
  };
}

class MetaDatum {
  MetaDatum({
    this.id,
    this.key,
    this.value,
  });

  int? id;
  String? key;
  String? value;

  factory MetaDatum.fromJson(String str) => MetaDatum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MetaDatum.fromMap(Map<String, dynamic> json) => MetaDatum(
    id: json["id"],
    key: json["key"],
    value: json["value"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "key": key,
    "value": value,
  };
}
