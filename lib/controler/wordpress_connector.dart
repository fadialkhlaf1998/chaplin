
import 'dart:convert';
import 'package:chaplin_new_version/model/category.dart';
import 'package:chaplin_new_version/model/customer.dart';
import 'package:chaplin_new_version/model/global.dart';
import 'package:chaplin_new_version/model/music.dart';
import 'package:chaplin_new_version/model/music_json.dart';
import 'package:chaplin_new_version/model/order.dart';
import 'package:chaplin_new_version/model/product.dart';
import 'package:http/http.dart' as http;

class WordPressConnecter {
  static String web_url = "https://chaplinuae.com";
  static String web_service_name = "wp-json/wp/v2";
  static String wooComerce_name = "/wc-api/v2";
  static String consumer_key="ck_640431af58d858cbf2ade27ebbfc4dcd9837d697";
  static String consumer_secret="cs_4c52fa2c203caf60ad6f9d4ce7952231f224f4e5";

  static Future<List<Product>> get_products(int category_id) async {
    try {
      var url = Uri.parse(web_url+'/wp-json/wc/v3/products?category=$category_id&consumer_key=ck_640431af58d858cbf2ade27ebbfc4dcd9837d697&consumer_secret=cs_4c52fa2c203caf60ad6f9d4ce7952231f224f4e5');
      var responce = await http.get(url);
      List<Product> result = <Product>[];
      var products = jsonDecode(responce.body) as List;
      for (int i = 0; i < products.length; i++) {
        result.add(Product.fromMap(products[i]));
      }
      return result;
      //return <Product>[];
    } on Exception catch (e) {
      print('***********');
      print(e);
      return <Product>[];
    }
  }

  static Future<List<Product>> get_products_search(String query) async {
    try {
      var url = Uri.parse(web_url+'/wp-json/wc/v3/products?search=$query&consumer_key=ck_640431af58d858cbf2ade27ebbfc4dcd9837d697&consumer_secret=cs_4c52fa2c203caf60ad6f9d4ce7952231f224f4e5');
      var responce = await http.get(url);
      List<Product> result = <Product>[];
      var products = jsonDecode(responce.body) as List;
      for (int i = 0; i < products.length; i++) {
        result.add(Product.fromMap(products[i]));
      }
      return result;
      //return <Product>[];
    } on Exception catch (e) {
      print('***********');
      print(e);
      return <Product>[];
    }
  }

  static Future<List<ProductCategory>> get_category() async {
    try {
      var url = Uri.parse(web_url+'/wc-api/v2/products/categories?consumer_key=ck_640431af58d858cbf2ade27ebbfc4dcd9837d697&consumer_secret=cs_4c52fa2c203caf60ad6f9d4ce7952231f224f4e5');
      var responce = await http.get(url);
      List<ProductCategory> result = <ProductCategory>[];
      var categories = jsonDecode(responce.body)["product_categories"] as List;
      for (int i = 0; i < categories.length; i++) {
        ProductCategory productCategory=ProductCategory.fromMap(categories[i]);
        if(!productCategory.name!.toLowerCase().contains("music")&&!productCategory.name!.toLowerCase().contains("uncategorized"))
            result.add(productCategory);
      }
      return result;
    } on Exception catch (_) {
      return <ProductCategory>[];
    }
  }

  static Future<bool> post_order(Map<String,dynamic> map)async{
    try{
      var headers = {
        'Content-Type': 'application/json'
      };
      var request = http.Request('POST', Uri.parse(web_url+'/wp-json/wc/v3/orders?consumer_key=ck_640431af58d858cbf2ade27ebbfc4dcd9837d697&consumer_secret=cs_4c52fa2c203caf60ad6f9d4ce7952231f224f4e5'));
      request.body = json.encode(map);
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        return false;
      }
      else {
        Global.save_order(<ProductCount>[]);
        Global.load_order();
        return true;
      }
    }on Exception catch(_){
      return false;
    }
  }

  static Future<bool> post_customer(Map<String,dynamic> map)async{
    try{
      print(json.encode(map));
      var headers = {
        'Content-Type': 'application/json'
      };
      var request = http.Request('POST', Uri.parse(web_url+'/wp-json/wc/v3/customers?consumer_key=ck_640431af58d858cbf2ade27ebbfc4dcd9837d697&consumer_secret=cs_4c52fa2c203caf60ad6f9d4ce7952231f224f4e5'));
      request.body = json.encode(map);
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(response);
        return false;
      }
      else {

        return true;
      }
    }on Exception catch(_){
      return get_customer(map["email"]);
    }
  }
  static Future<bool> put_customer(Map<String,dynamic> map,int customer_id)async{
    try{
      print(json.encode(map));
      var headers = {
        'Content-Type': 'application/json'
      };
      //PUT https://example.com/wp-json/wc/v3/customers/25
      var request = http.Request('PUT', Uri.parse(web_url+'/wp-json/wc/v3/customers/$customer_id?consumer_key=ck_640431af58d858cbf2ade27ebbfc4dcd9837d697&consumer_secret=cs_4c52fa2c203caf60ad6f9d4ce7952231f224f4e5'));
      request.body = json.encode(map);
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print("*******");
        print(await response.stream.bytesToString());
        get_customer(Global.email);
        return true;
      }
      else {
        print(response.reasonPhrase);
        get_customer(Global.email);
        return true;
      }
    }on Exception catch(_){
      return false;
    }
  }

  static Future<bool> get_customer(String email)async{
    try{

      var request = http.Request('GET', Uri.parse(web_url+'/wp-json/wc/v3/customers?email=$email&consumer_key=ck_640431af58d858cbf2ade27ebbfc4dcd9837d697&consumer_secret=cs_4c52fa2c203caf60ad6f9d4ce7952231f224f4e5'));

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var custumer =jsonDecode(await response.stream.bytesToString()) as List;
        if(custumer.isNotEmpty){
          Global.customer = Customer.fromMap(custumer[0]);

          return true;
        }
        return false;
      }
      else {
        return false;
      }
    }on Exception catch(_){
      return false;
    }
  }

  static Future<List<Music>> get_music() async {
    try {
      var url = Uri.parse(web_url+'/wc-api/v2/products/categories?consumer_key=ck_640431af58d858cbf2ade27ebbfc4dcd9837d697&consumer_secret=cs_4c52fa2c203caf60ad6f9d4ce7952231f224f4e5');
      var responce = await http.get(url);
      ProductCategory? cat ;
      var categories = jsonDecode(responce.body)["product_categories"] as List;

      for (int i = 0; i < categories.length; i++) {
        ProductCategory productCategory = ProductCategory.fromMap(
            categories[i]);
        if (productCategory.name!.toLowerCase().contains("music")) {
          cat = productCategory;
          break;
        }
      }
      //print(cat!.id!);
      //String productsJson=await get_products_string(cat.id!);
      List<MusicJson> products=await get_products_string(cat!.id!);
      List<Music> result=<Music>[];
      String link="non";
      String art="non";
      for ( int i = 0 ; i < products.length ; i++ ){
        for(int j=0;j<products[i].metaData!.length;j++){
          if(products[i].metaData![j].key=="youtube_link"){
            link=products[i].metaData![j].value!;
          }
          if(products[i].metaData![j].key=="artist"){
            art=products[i].metaData![j].value!;
          }
      }
        if(art!="non"&&link!="non"){
          result.add(Music(products[i].name!,link,art));
        }


      }
      //print(productsJson);

      return result;
    } on Exception catch (_) {
      print("-----------");
      return <Music>[];
    }
  }
  static Future<List<MusicJson>> get_products_string(int category_id) async {
    try {
      var url = Uri.parse(web_url+'/wp-json/wc/v3/products?category=$category_id&consumer_key=ck_640431af58d858cbf2ade27ebbfc4dcd9837d697&consumer_secret=cs_4c52fa2c203caf60ad6f9d4ce7952231f224f4e5');
      var responce = await http.get(url);
      List<MusicJson> musics=<MusicJson>[];
      var products = jsonDecode(responce.body) as List;
      for (int i = 0; i < products.length; i++) {
        musics.add(MusicJson.fromMap(products[i]));
      }
      return musics;
      //return <Product>[];
    } on Exception catch (e) {
      print('***********');
      print(e);
      return <MusicJson>[];
    }
  }
}

