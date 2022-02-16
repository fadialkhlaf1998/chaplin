import 'dart:convert';

import 'package:chaplin_new_version/controler/setting.dart';
import 'package:chaplin_new_version/controler/wordpress_connector.dart';
import 'package:chaplin_new_version/model/customer.dart';
import 'package:chaplin_new_version/model/global.dart';
import 'package:chaplin_new_version/model/music.dart';
import 'package:chaplin_new_version/model/my_customer.dart';
import 'package:chaplin_new_version/model/my_responce.dart';
import 'package:chaplin_new_version/model/order.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:xml/xml.dart' as xml;

class Connecter {
  static String web_signIn_url="chaplinapp.maxart.ae";
  static String web_service_name="WebService.asmx";
  static String auth_1='60f232d451e877f0a6c0e884546353cc1998';
  static String auth_2='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148';
  static String url = "https://phpstack-548447-2379311.cloudwaysapps.com/";
  // static String url = "http://10.0.2.2:3000/";




  static Future<bool> sign_up(String email,String password,String firstname,String lastname)async{
    // try {
    //   email=email.replaceAll(" ", "");
    //   password=password.replaceAll(" ", "");
    //   var responce=await http.get(new Uri.http(web_signIn_url, web_service_name+"/add_customer_and_send_verification",
    //       { "authntication_1" : auth_1,"authntication_2":auth_2,"email": email,"password":password}));
    //   var storeDocument = xml.parse(responce.body);
    //   print(storeDocument);
    //   if(storeDocument.text.contains("sucses")){
    //     AppSetting.save(email, password);
    //     return true;
    //   }else{
    //     return false;
    //   }
    // }on Exception catch(_){
    //   return false;
    // }

    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(url+'add_user'));
    request.body = json.encode({
      "email": email,
      "pass": password,
      "firstname":firstname,
      "lastname":lastname
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    print(response.stream.toString());
    if (response.statusCode == 200) {
      String json = await response.stream.bytesToString();
      // Result result = Result.fromJson(json);
      // Global.customer=result.data.first;
      AppSetting.save(email, password);
      return true;
    }
    else {
      String json = await response.stream.bytesToString();
      print('/////////////');
      print(json);
      print('/////////////');
      // Result result = Result.fromJson(json);
      return false;
    }
  }

  static Future<bool> log_in(String email,String password)async{
    // try {
    //   email=email.replaceAll(" ", "");
    //   password=password.replaceAll(" ", "");
    //   var responce=await http.get(new Uri.http(web_signIn_url, web_service_name+"/login",
    //       { "authntication_1" : auth_1,"authntication_2":auth_2,"email": email,"password":password}));
    //   var storeDocument = xml.parse(responce.body);
    //   if(storeDocument.text.contains("sucses")){
    //     AppSetting.save(email, password);
    //     AppSetting.set_verificated(true);
    //     WordPressConnecter.get_customer(email);
    //     return true;
    //   }else{
    //     return false;
    //   }
    //
    // }on Exception catch(_){
    //   return false;
    // }

    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(url+'log_in'));
    request.body = json.encode({
      "email": email,
      "pass": password
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String json = await response.stream.bytesToString();
      print(json);
      Result result = Result.fromJson(json);
      Global.customer_id=result.data.first.id;
      AppSetting.save(email, password);
      AppSetting.set_verificated(true);
      return true;
    }
    else {
      String json = await response.stream.bytesToString();
      // Result result = Result.fromJson(json);
      print(json);
      return false;
    }
  }

  static Future<bool> code_verification(String email,String password,String code)async{
    // try {
    //   email=email.replaceAll(" ", "");
    //   password=password.replaceAll(" ", "");
    //   code=code.replaceAll(" ", "");
    //   var responce=await http.get(new Uri.http(web_signIn_url, web_service_name+"/insert_code",
    //       { "authntication_1" : auth_1,"authntication_2":auth_2,"email": email,"password":password,"code":code}));
    //   var storeDocument = xml.parse(responce.body);
    //   if(storeDocument.text.contains("sucses")){
    //     AppSetting.set_verificated(true);
    //     return true;
    //   }else{
    //     return false;
    //   }
    // }on Exception catch(_){
    //   return false;
    // }
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(url+'verify_email'));
    request.body = json.encode({
      "email": email,
      "code": code
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String json = await response.stream.bytesToString();
      Map<String,dynamic> msg= jsonDecode(json);
      AppSetting.set_verificated(true);
      return true;
    }
    else {
      String json = await response.stream.bytesToString();
      Map<String,dynamic> msg= jsonDecode(json);
      return false;
    }
  }

  static Future<bool> resend_code(String email)async{
    // try {
    //   email=email.replaceAll(" ", "");
    //   var responce=await http.get(new Uri.http(web_signIn_url, web_service_name+"/resend_code",
    //       { "authntication_1" : auth_1,"authntication_2":auth_2,"email": email}));
    //   var storeDocument = xml.parse(responce.body);
    //   if(storeDocument.text.contains("sucses")){
    //     return true;
    //   }else{
    //     return false;
    //   }
    // }on Exception catch(_){
    //   return false;
    // }
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(url+'resend_code'));
    request.body = json.encode({
      "email": email
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String json = await response.stream.bytesToString();
      Map<String,dynamic> msg= jsonDecode(json);
      print(msg);
      return true;
    }
    else {
      String json = await response.stream.bytesToString();
      Map<String,dynamic> msg= jsonDecode(json);
      print(msg);
      return false;
    }
  }

  static Future<bool> forget_password(String email)async{
    // try {
    //   email=email.replaceAll(" ", "");
    //   var responce=await http.get(new Uri.http(web_signIn_url, web_service_name+"/forget_Password",
    //       { "authntication_1" : auth_1,"authntication_2":auth_2,"email": email}));
    //   var storeDocument = xml.parse(responce.body);
    //
    //   if(storeDocument.text.contains("sucses")){
    //     return true;
    //   }else{
    //     return false;
    //   }
    // }on Exception catch(_){
    //   return false;
    // }
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(url+'forget_password'));
    request.body = json.encode({
      "email": email
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String json = await response.stream.bytesToString();
      Map<String,dynamic> msg= jsonDecode(json);
      return true;
    }
    else {
      String json = await response.stream.bytesToString();
      Map<String,dynamic> msg= jsonDecode(json);
      return false;
    }
  }

  static Future<bool> insert_music(String name,String link)async{
    try {
      //name=name.replaceAll(" ", "");
      var responce=await http.get(new Uri.http(web_signIn_url, web_service_name+"/inser_music",
          {"name":name,"link":link}));
      //var storeDocument = xml.parse(responce.body);
      print(responce.body);
      return true;

    }on Exception catch(_){
      return false;
    }
  }

  static Future<List<Music>> get_music_list()async{
    try {
      //name=name.replaceAll(" ", "");
      var responce=await http.get(new Uri.http(web_signIn_url, web_service_name+"/get_music_list", {}));
      var storeDocument = xml.parse(responce.body);
      //print(storeDocument.text);
      List<Music> music=<Music>[];
      var json = jsonDecode(storeDocument.text) as List;
      for(int i=0 ; i< json.length ; i++){
        music.add(Music(json[i], "link", "artist"));
      }

      return music;

    }on Exception catch(_){
      return <Music>[];
    }
  }

  static Future<bool> check_internet() async {
    // var connectivityResult = await (Connectivity().checkConnectivity());
    // if (connectivityResult == ConnectivityResult.none) {
    //   return false;
    // } else if (connectivityResult == ConnectivityResult.wifi) {
    //   return true;
    // }else if(connectivityResult == ConnectivityResult.mobile){
    //   return true;
    // }
    return true;
  }

  static Future<bool> send_email(String tableNumber) async {
    try{
      String subject = 'Table Number: ' + tableNumber;
      String? body = '';
      String temp = '';
      for (int i = 0; i < Global.my_order.length; i++) {
        temp = "Dish name: " + Global.my_order[i].product!.name!
            + " | Quantity: " + Global.my_order[i].count.toString()+"\n";
        body = body! + temp;
      }
      body = 'Time: ' + DateFormat('kk:mm:ss \n').format(DateTime.now()) +
              'Day: ' + DateFormat('EEE d MMM\n').format(DateTime.now()) +
          '__________________________\n\n' + body!;
      var headers = {
        'Content-Type': 'application/json',
        'Cookie': 'connect.sid=s%3AHSWpm5TVO9_OvvOxMfIOaVRfkfCoQ0c5.VwKalVMNVq8M2a9JLRPOoJR6N3KLQMk6%2Bm7CqYxBNLE'
      };
      var request = http.Request('POST', Uri.parse('https://phpstack-548447-2379311.cloudwaysapps.com/send_mail'));
      request.body = json.encode({
        "msg": body,
        "subject": subject
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
        Global.delete_order();
      }
      else {
        print(response.reasonPhrase);
      }
      return true;

    }on Exception catch(e){
      return false;
    }

  }
  ///-------------logIn-------------


  static Future<MyReult> change_password(String email,String newpass)async{
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(url+'change_password'));
    request.body = json.encode({
      "email": email,
      "pass": newpass
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String json = await response.stream.bytesToString();
      Map<String,dynamic> msg= jsonDecode(json);
      // Store.saveLoginInfo(email, newpass);
      return MyReult(200,msg["message"],true);
    }
    else {
      String json = await response.stream.bytesToString();
      Map<String,dynamic> msg= jsonDecode(json);
      return MyReult(500,msg["message"],false);
    }
  }
  //
  // static Future<bool> check_internet()async{
  //   // return false;
  //   var connectivityResult = await (Connectivity().checkConnectivity());
  //   if (connectivityResult == ConnectivityResult.mobile) {
  //     // I am connected to a mobile network.
  //     return true;
  //   } else if (connectivityResult == ConnectivityResult.wifi) {
  //     // I am connected to a wifi network.
  //     return true;
  //   }else{
  //     return false;
  //   }
  //
  // }

}
