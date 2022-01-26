import 'package:chaplin_new_version/controler/connector.dart';
import 'package:chaplin_new_version/controler/store.dart';
import 'package:chaplin_new_version/controler/wordpress_connector.dart';
import 'package:chaplin_new_version/model/global.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSetting {
  static save(String email,String password){
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString("email", email);
      prefs.setString("password", password);
    });
  }

  static load(){
    SharedPreferences.getInstance().then((prefs) {
      Global.email=prefs.getString("email")??"non";
      Global.password=prefs.getString("password")??"non";
      Global.timer=prefs.getString("timer")??"non";
      Global.customer_id=prefs.getInt("customer_id")??-1;

      if(Global.email!='non'&&Global.password!='non'){
        WordPressConnecter.get_customer(Global.email);
        Connecter.log_in(Global.email, Global.password);
      }

    });
    WordPressConnecter.get_customer(Global.email);
    Global.load_order();
    Store.load_wishlist();
  }

  static is_verificated(){
    SharedPreferences.getInstance().then((prefs) {
      Global.is_signIn = prefs.getBool("code")??false;
    });
  }
  static set_verificated(bool verify){
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool("code",verify);
    });
  }
  static set_timer(String timer){
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString("timer",timer);
    });
  }
  static get_timer(){
    SharedPreferences.getInstance().then((prefs) {
      Global.timer=prefs.getString("timer")??"non";
    });
  }
  static set_customer_id(int customer_id){
    SharedPreferences.getInstance().then((prefs) {
      prefs.setInt("customer_id",customer_id);
    });
  }

}