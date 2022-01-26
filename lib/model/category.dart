// To parse this JSON data, do
//
//     final productCategory = productCategoryFromMap(jsonString);

import 'dart:convert';



class ProductCategory {
  ProductCategory({
    this.id,
    this.name,
    this.slug,
    this.parent,
    this.description,
    this.display,
    this.image,
    this.count,
  });

  int? id;
  String? name;
  String? slug;
  int? parent;
  String? description;
  String? display;
  String? image;
  int? count;

  factory ProductCategory.fromJson(String str) => ProductCategory.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductCategory.fromMap(Map<String, dynamic> json) => ProductCategory(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    parent: json["parent"],
    description: json["description"],
    display: json["display"],
    image: json["image"],
    count: json["count"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "slug": slug,
    "parent": parent,
    "description": description,
    "display": display,
    "image": image,
    "count": count,
  };
}
