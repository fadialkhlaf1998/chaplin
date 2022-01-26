// To parse this JSON data, do
//
//     final order = orderFromMap(jsonString);

import 'dart:convert';
import 'package:chaplin_new_version/model/customer.dart';
import 'package:chaplin_new_version/model/product.dart';

class Order {
  Order({
    this.paymentMethod,
    this.paymentMethodTitle,
    this.setPaid,
    this.billing,
    this.shipping,
    this.lineItems,
    this.status,
    this.currency,
   // this.shippingLines,
  });

  String? paymentMethod;
  String? paymentMethodTitle;
  bool? setPaid;
  Billing? billing;
  Shipping? shipping;
  List<LineItem>? lineItems;
  String? status;
  String? currency;
  //List<ShippingLine>? shippingLines;

  factory Order.fromJson(String str) => Order.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Order.fromMap(Map<String, dynamic> json) => Order(
    paymentMethod: json["payment_method"],
    paymentMethodTitle: json["payment_method_title"],
    setPaid: json["set_paid"],
    billing: Billing.fromMap(json["billing"]),
    shipping: Shipping.fromMap(json["shipping"]),
    lineItems: List<LineItem>.from(json["line_items"].map((x) => LineItem.fromMap(x))),
    status: json["status"],
    currency: json["currency"],
    //shippingLines: List<ShippingLine>.from(json["shipping_lines"].map((x) => ShippingLine.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "payment_method": paymentMethod,
    "payment_method_title": paymentMethodTitle,
    "set_paid": setPaid,
    "billing": billing!.toMap(),
    "shipping": shipping!.toMap(),
    "line_items": List<dynamic>.from(lineItems!.map((x) => x.toMap())),
    "status": status,
    "currency": currency,
    //"shipping_lines": List<dynamic>.from(shippingLines!.map((x) => x.toMap())),
  };
}


class LineItem {
  LineItem({
    this.productId,
    this.quantity,
  });


  LineItem.constructor(this.productId, this.quantity);

  int? productId;
  int? quantity;

  factory LineItem.fromJson(String str) => LineItem.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LineItem.fromMap(Map<String, dynamic> json) => LineItem(
    productId: json["product_id"],
    quantity: json["quantity"],
  );

  Map<String, dynamic> toMap() => {
    "product_id": productId,
    "quantity": quantity,
  };
}



class ShippingLine {
  ShippingLine({
    this.methodId,
    this.methodTitle,
    this.total,
  });

  String? methodId;
  String? methodTitle;
  String? total;

  factory ShippingLine.fromJson(String str) => ShippingLine.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ShippingLine.fromMap(Map<String, dynamic> json) => ShippingLine(
    methodId: json["method_id"],
    methodTitle: json["method_title"],
    total: json["total"],
  );

  Map<String, dynamic> toMap() => {
    "method_id": methodId,
    "method_title": methodTitle,
    "total": total,
  };
}

class ProductCount{
  Product? product;
  int? count;
  double? total;

  ProductCount(this.product, this.count,this.total);
  ProductCount.withMap({
    this.product,
    this.count,
    this.total,
  });
  factory ProductCount.fromJson(String str) => ProductCount.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductCount.fromMap(Map<String, dynamic> json) => ProductCount.withMap(
    product: Product.fromMap(json["product"]),
    count: json["count"],
    total: json["total"]
  );

  Map<String, dynamic> toMap() => {
    "product": product!.toMap(),
    "count": count,
    "total": total,
  };
}
/*
{
  "id": 727,
  "parent_id": 0,
  "number": "727",
  "order_key": "wc_order_58d2d042d1d",
  "created_via": "rest-api",
  "version": "3.0.0",
  "status": "processing",
  "currency": "USD",
  "date_created": "2017-03-22T16:28:02",
  "date_created_gmt": "2017-03-22T19:28:02",
  "date_modified": "2017-03-22T16:28:08",
  "date_modified_gmt": "2017-03-22T19:28:08",
  "discount_total": "0.00",
  "discount_tax": "0.00",
  "shipping_total": "10.00",
  "shipping_tax": "0.00",
  "cart_tax": "1.35",
  "total": "29.35",
  "total_tax": "1.35",
  "prices_include_tax": false,
  "customer_id": 0,
  "customer_ip_address": "",
  "customer_user_agent": "",
  "customer_note": "",
  "billing": {
    "first_name": "John",
    "last_name": "Doe",
    "company": "",
    "address_1": "969 Market",
    "address_2": "",
    "city": "San Francisco",
    "state": "CA",
    "postcode": "94103",
    "country": "US",
    "email": "john.doe@example.com",
    "phone": "(555) 555-5555"
  },
  "shipping": {
    "first_name": "John",
    "last_name": "Doe",
    "company": "",
    "address_1": "969 Market",
    "address_2": "",
    "city": "San Francisco",
    "state": "CA",
    "postcode": "94103",
    "country": "US"
  },
  "payment_method": "bacs",
  "payment_method_title": "Direct Bank Transfer",
  "transaction_id": "",
  "date_paid": "2017-03-22T16:28:08",
  "date_paid_gmt": "2017-03-22T19:28:08",
  "date_completed": null,
  "date_completed_gmt": null,
  "cart_hash": "",
  "meta_data": [
    {
      "id": 13106,
      "key": "_download_permissions_granted",
      "value": "yes"
    }
  ],
  "line_items": [
    {
      "id": 315,
      "name": "Woo Single #1",
      "product_id": 93,
      "variation_id": 0,
      "quantity": 2,
      "tax_class": "",
      "subtotal": "6.00",
      "subtotal_tax": "0.45",
      "total": "6.00",
      "total_tax": "0.45",
      "taxes": [
        {
          "id": 75,
          "total": "0.45",
          "subtotal": "0.45"
        }
      ],
      "meta_data": [],
      "sku": "",
      "price": 3
    },
    {
      "id": 316,
      "name": "Ship Your Idea &ndash; Color: Black, Size: M Test",
      "product_id": 22,
      "variation_id": 23,
      "quantity": 1,
      "tax_class": "",
      "subtotal": "12.00",
      "subtotal_tax": "0.90",
      "total": "12.00",
      "total_tax": "0.90",
      "taxes": [
        {
          "id": 75,
          "total": "0.9",
          "subtotal": "0.9"
        }
      ],
      "meta_data": [
        {
          "id": 2095,
          "key": "pa_color",
          "value": "black"
        },
        {
          "id": 2096,
          "key": "size",
          "value": "M Test"
        }
      ],
      "sku": "Bar3",
      "price": 12
    }
  ],
  "tax_lines": [
    {
      "id": 318,
      "rate_code": "US-CA-STATE TAX",
      "rate_id": 75,
      "label": "State Tax",
      "compound": false,
      "tax_total": "1.35",
      "shipping_tax_total": "0.00",
      "meta_data": []
    }
  ],
  "shipping_lines": [
    {
      "id": 317,
      "method_title": "Flat Rate",
      "method_id": "flat_rate",
      "total": "10.00",
      "total_tax": "0.00",
      "taxes": [],
      "meta_data": []
    }
  ],
  "fee_lines": [],
  "coupon_lines": [],
  "refunds": [],
  "_links": {
    "self": [
      {
        "href": "https://example.com/wp-json/wc/v3/orders/727"
      }
    ],
    "collection": [
      {
        "href": "https://example.com/wp-json/wc/v3/orders"
      }
    ]
  }
}
*/