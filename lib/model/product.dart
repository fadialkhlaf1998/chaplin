// To parse this JSON data, do
//
//     final product = productFromMap(jsonString);

import 'dart:convert';

class Product {
  Product({
    this.id,
    this.name,
    this.permalink,
    this.description,
    this.shortDescription,
    this.price,
    this.regularPrice,
    this.salePrice,
    this.images,
  });

  int? id;
  String? name;
  String? permalink;
  String? description;
  String? shortDescription;
  String? price;
  String? regularPrice;
  String? salePrice;
  bool favorite=false;
  List<ProductImage>? images;

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    permalink: json["permalink"],
    description: json["description"],
    shortDescription: json["short_description"],
    price: json["price"]==""?"0.0":json["price"],
    regularPrice: json["regular_price"],
    salePrice: json["sale_price"],
    images: List<ProductImage>.from(json["images"].map((x) => ProductImage.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "permalink": permalink,
    "description": description,
    "short_description": shortDescription,
    "price": price,
    "regular_price": regularPrice,
    "sale_price": salePrice,
    "images": List<dynamic>.from(images!.map((x) => x.toMap())),
  };
}

class ProductImage {
  ProductImage({
    this.id,
    this.src,
  });

  int? id;
  String? src;

  factory ProductImage.fromJson(String str) => ProductImage.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductImage.fromMap(Map<String, dynamic> json) => ProductImage(
    id: json["id"],
    src: json["src"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "src": src,
  };
}
