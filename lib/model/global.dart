import 'dart:convert';
import 'dart:io';
import 'package:chaplin_new_version/controler/connector.dart';
import 'package:chaplin_new_version/controler/wordpress_connector.dart';
import 'package:chaplin_new_version/main.dart';
import 'package:chaplin_new_version/model/category.dart';
import 'package:chaplin_new_version/model/product.dart';
import 'package:chaplin_new_version/model/order.dart';
import 'package:chaplin_new_version/model/story.dart';
import 'package:chaplin_new_version/view/complete_order.dart';
import 'package:chaplin_new_version/view/qr_scanner.dart';
import 'package:chaplin_new_version/view/sign_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'customer.dart';


class Global{
  static String email="non";
  static String password="non";
  static String code="non";
  static bool had_music=false;
  static bool is_signIn=false;
  static String timer="non";
  static String music_timer="non";
  static bool request_failed=false;
  static int customer_id=-1;
  static List<Story> stories = <Story>[];
  static Customer? customer;
  static List<Product> products=<Product>[];
  static List<Product> wishlist=<Product>[];
  static List<ProductCategory> categories=<ProductCategory>[];
  static List<ProductCount> my_order=<ProductCount>[];
  static double total=0;
  static Order? order;
  static bool selected=true;
  static bool onTheTable = true;
  static bool delivery = false;
  static int? option;
  static String? table_number;
  static String phone= "";
  static String? description;

  static add_to_order(Product product,int count){
    bool exist=false;
    int index=-1;
    for(int i=0;i<Global.my_order.length;i++) {
      if(product.id==Global.my_order[i].product!.id){
        index=i;
        exist=true;
        break;
      }
    }
    if(!exist){
      print('**************');
      print(product.price!);
      Global.my_order.add(ProductCount(product, count,double.parse(product.price!)*count));
    }else{
      Global.my_order[index].count=Global.my_order[index].count!+count;
      Global.my_order[index].total=Global.my_order[index].count!*double.parse(Global.my_order[index].product!.price!);
    }
    save_order(Global.my_order);
  }
  static save_order(List<ProductCount> my_order){
    SharedPreferences.getInstance().then((prefs){
      if(my_order.isNotEmpty){
        prefs.setString("order", List<dynamic>.from(my_order.map((x) => x.toJson())).toString());
      }else{
        prefs.setString("order","[]");
      }

    });
  }
  static load_order(){
    Global.my_order.clear();
    SharedPreferences.getInstance().then((prefs){
      String json=prefs.getString("order")??"[]";
      var json_data=jsonDecode(json) as List;
      for(int i=0;i<json_data.length;i++){
        Global.my_order.add(ProductCount.fromMap(json_data[i]));
      }
      get_total();
      //Global.my_order.addAll(List<ProductCount>.from(ProductCount.fromMap(json.decode(json)).map((x) => ProductCount.fromMap(x))));
    });
  }
  static delete_order() async{
    Global.my_order.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("order");
  }

  static Future<void> get_cart(BuildContext context){
    return showMaterialModalBottomSheet<void>(
      context: context,
      barrierColor: Color.fromRGBO(15, 15, 15, 50),
      backgroundColor: Colors.transparent,
      enableDrag: true,
      useRootNavigator: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (context,setstate){
              return Container(
                height: MediaQuery.of(context).size.height*0.85,
                decoration: BoxDecoration(
                  color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25),
                    )
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height*0.62,
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: MediaQuery.of(context).size.height*0.1,
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.shopping_cart,color: Colors.red,size: 35,),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text("TU CANASTA",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),)
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      top: 30,
                                      left: 15,
                                      child: GestureDetector(
                                        onTap: (){
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.white),
                                          child: CircleAvatar(child: Icon(Icons.cancel,size: 25,color: Colors.black87,),backgroundColor: Colors.white,),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: MediaQuery.of(context).size.height*0.51,
                                child: my_order.isNotEmpty ?
                                ListView.builder(
                                    itemCount: Global.my_order.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(right: 8,left: 8, top: 0),
                                        child: GestureDetector(
                                          onTap: () {

                                          },
                                          child: Container(
                                            //margin: EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 10),
                                            height: 130,
                                            width: MediaQuery.of(context).size.width,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(15)
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context).size.width * 0.35,
                                                  height: MediaQuery.of(context).size.width * 0.35,
                                                  margin: EdgeInsets.only(top: 15,bottom: 15),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.rectangle,
                                                    borderRadius: BorderRadius.circular(15),
                                                    image: DecorationImage(
                                                      image: NetworkImage(Global.my_order[index].product!.images!.first.src!),
                                                      fit: BoxFit.cover
                                                    )

                                                  ),
                                                  // child: ClipRRect(
                                                  //   borderRadius: BorderRadius.circular(15),
                                                  //   child: Image.network(Global.my_order[index].product!.images!.first.src!),
                                                  // ),

                                                ),
                                                //SizedBox(width: 5,),
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Spacer(),
                                                    Container(
                                                      width: MediaQuery.of(context).size.width * 0.3,
                                                      child: Text(Global.my_order[index].product!.name!,
                                                        overflow: TextOverflow.ellipsis,
                                                        maxLines: 2,
                                                        style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                                    ),
                                                    SizedBox(height: 20,),
                                                    Row(
                                                      children: [
                                                        Text("AED "+Global.my_order[index].total.toString(),style: TextStyle(fontSize: 18,color: Colors.red,fontWeight: FontWeight.bold),),
                                                        IconButton(onPressed: (){
                                                          setstate(() {
                                                            Global.my_order.removeAt(index);
                                                            Global.get_total();
                                                            Global.total;
                                                          }
                                                          );
                                                        }, icon: Icon(Icons.delete))
                                                      ],
                                                    ),
                                                    Spacer(),
                                                  ],
                                                ),
                                                Container(
                                                  height: 100,
                                                  width: 50,
                                                  decoration: BoxDecoration(
                                                    color: Colors.black,
                                                    borderRadius: BorderRadius.circular(10),
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: [
                                                     Flexible(
                                                       flex: 1,
                                                       child: IconButton(
                                                              onPressed: (){
                                                            setstate(() {
                                                              Global.my_order[index].count=Global.my_order[index].count!+1;
                                                              Global.my_order[index].total=Global.my_order[index].count!*double.parse(Global.my_order[index].product!.price!);
                                                              Global.get_total();
                                                              Global.total;
                                                            }
                                                            );
                                                          }, icon: Icon(Icons.add,color: Colors.white, size: 20,)),
                                                     ),
                                                      Flexible(
                                                        flex: 1,
                                                          child: Text(Global.my_order[index].count.toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),)),
                                                      Flexible(
                                                        flex: 1,
                                                        child: IconButton(
                                                              onPressed: (){
                                                                setstate(() {
                                                                  if(Global.my_order[index].count!>1){
                                                                    Global.my_order[index].count=Global.my_order[index].count!-1;
                                                                    Global.my_order[index].total=Global.my_order[index].count!*double.parse(Global.my_order[index].product!.price!);
                                                                    Global.get_total();
                                                                    Global.total;
                                                                  }else if(Global.my_order[index].count==1){
                                                                    Global.my_order.removeAt(index);
                                                                    Global.get_total();
                                                                    Global.total;
                                                                  }
                                                                }
                                                                );

                                                              }, icon: Icon(Icons.remove,color: Colors.white, size: 20,)),
                                                      ),

                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }) : Center(child: Text('There aren\'t any orders yet',style: TextStyle(fontSize: 18, color: Colors.black),),),
                              ),
                            //SizedBox(height: MediaQuery.of(context).size.height * 0.5,)
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 8,
                              blurRadius: 7,
                              offset: Offset(2, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 5,bottom: 0,left: 25,right: 25),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height * 0.12,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text("choose how to order",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            setstate(() {
                                              onTheTable = true;
                                              delivery = false;
                                              selected = !selected;
                                            });
                                          },
                                          child: Container(
                                            height: 20,
                                            width: 20,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle, color: selected ? Colors.black : Colors.white,
                                                border: Border.all(width: 2, color: Colors.black)
                                            ),
                                            child: Padding(
                                                padding: const EdgeInsets.all(3.0),
                                                child: selected ? Icon(
                                                  Icons.check,
                                                  size: 10.0,
                                                  color: Colors.white,
                                                ) : Container()
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 15,),
                                        Text("on the table",style: TextStyle(fontSize: 16,),)
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            setstate(() {
                                              onTheTable = false;
                                              delivery = true;
                                              selected = !selected;
                                            });
                                          },
                                          child: Container(
                                            height: 20,
                                            width: 20,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle, color: !selected ? Colors.black : Colors.white,
                                                border: Border.all(width: 2, color: Colors.black)
                                            ),
                                            child: Padding(
                                                padding: const EdgeInsets.all(3.0),
                                                child: !selected ? Icon(
                                                  Icons.check,
                                                  size: 10.0,
                                                  color: Colors.white,
                                                ) : Container()
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 15,),
                                        Text("Delivery",style: TextStyle(fontSize: 16,),)
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              //height: 70,
                              decoration: BoxDecoration(
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      if(!Global.is_signIn){
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => Sign_In()),);
                                      }else if(Global.is_signIn&&Global.my_order.isNotEmpty && Global.onTheTable){
                                        option = 1;
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(builder: (context) => QRScanner())
                                        );
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(builder: (context) => const CompleteOrder()),);
                                      }
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width*0.75,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.circular(15)
                                      ),
                                      child: Center(
                                        child: Text("complete the order",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 30,)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            });
      },
    );
  }
  static double get_total(){
    Global.total=0;
    for (int i = 0 ; i < Global.my_order.length ; i++){
      Global.total+=Global.my_order[i].total!;
    }
    return Global.total;
  }
  static Order get_order(){
    Global.order=Order();
    for(int i=0;i<Global.my_order.length;i++){
      Global.order!.lineItems=<LineItem>[];
      Global.order!.lineItems!.add(LineItem.constructor(Global.my_order[i].product!.id!,Global.my_order[i].count));
    }
    Global.order!.currency="AED";
    Global.order!.status="completed";
    return Global.order!;
  }

  
  static save_lang(BuildContext context,String lang){
    SharedPreferences.getInstance().then((prefs){
      prefs.setString("language", lang);
      MyApp.set_local(context, Locale(lang));
    });
  }


  /*static Future sendEmail1() async{
    final emailAddress = 'chaplinuae.com@gmail.com'; //fadi.kh38610130@gmail.com
    final accessToken = 'oxzugqcjoivdwref';

      final stmpServer = gmailSaslXoauth2(emailAddress, accessToken);
      final message = Message()
      ..from = Address(emailAddress)
        ..recipients = ['fadihaddad615@gmail.com']
          ..subject = 'subject'
          ..text = 'text';

      try{
        await send(message, stmpServer);
        print('successfully');
    }on MailerException catch (e){
        print(e);
    }

  }*/


}