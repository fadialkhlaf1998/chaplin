import 'dart:convert';

import 'package:chaplin_new_version/model/global.dart';
import 'package:chaplin_new_version/model/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Store {

  static int dur = 0;

  static Future<List<Product>> load_wishlist()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = prefs.getString("wishlist")??"non";
    if(jsonString=="non"){
      return <Product>[];
    }else{
      var jsonlist = jsonDecode(jsonString) as List;
      List<Product> list = <Product>[];
      for(int i=0;i<jsonlist.length;i++){
        list.add(Product.fromMap(jsonlist[i]));
      }
      Global.wishlist=list;
      return list;
    }
  }

  static save_wishlist(List<Product> _products){
    SharedPreferences.getInstance().then((prefs) {
      String myjson = json.encode(List<dynamic>.from(_products.map((x) => x.toMap())));
      prefs.setString("wishlist", myjson);
      load_wishlist();
    });
  }

  static add_to_wishlist(Product _products){
    SharedPreferences.getInstance().then((prefs) {
      Global.wishlist.add(_products);
      save_wishlist(Global.wishlist);
    });
  }

  static remove_from_wishlist(Product _products){
    for(int i=0;i<Global.wishlist.length;i++){
      if(Global.wishlist[i].id==_products.id){
        Global.wishlist.removeAt(i);

      }
    }
    save_wishlist(Global.wishlist);
  }

  static save_music_timer(){
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString("image_timer", DateTime.now().toString());
    });
  }

  static Future<bool> load_music_timer()async{
    var prefs = await SharedPreferences.getInstance();
    String time = prefs.getString("image_timer")?? "non";
    if(time=="non"){
        return true;
      }else{
        DateTime old = DateTime.parse(time);
        dur = 30 - (DateTime.now().minute - old.minute);
        print (dur.toString());
          if(old.year<DateTime.now().year){
            return true;
          }
          else if(DateTime.now().month>old.month){
            return true;
          }
          else if(DateTime.now().day>old.day){
            return true;
          }
          else if(((DateTime.now().hour*60)+DateTime.now().minute)>=((old.hour*60)+old.minute+30)){
            return true;
          }else{
            return false;
          }
    }


  }
}