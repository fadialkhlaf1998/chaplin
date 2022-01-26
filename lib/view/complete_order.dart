import 'package:chaplin_new_version/controler/wordpress_connector.dart';
import 'package:chaplin_new_version/model/global.dart';
import 'package:chaplin_new_version/model/order.dart';
import 'package:chaplin_new_version/view/billing.dart';
import 'package:chaplin_new_version/view/fail.dart';
import 'package:chaplin_new_version/view/my_fatoorah.dart';
import 'package:chaplin_new_version/view/shipping.dart';
import 'package:chaplin_new_version/view/sucss.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class CompleteOrder extends StatefulWidget {
  const CompleteOrder({Key? key}) : super(key: key);

  @override
  _CompleteOrderState createState() => _CompleteOrderState();
}

class _CompleteOrderState extends State<CompleteOrder> {
  int page=0;
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  bool loading=false;
  final snackBar_succc = SnackBar(content: Text('order completed'));
  final snackBar_fail = SnackBar(content: Text("some thing went wrong"));

  /**--------check box values--------*/
  bool shipping_and_billing=true;
  bool billing=false;
  bool payment_shipping=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height-MediaQuery.of(context).padding.top,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/login.png"),
              fit: BoxFit.cover
            )
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Global.customer!.billing!=null?
                _complete_order(context)
                :Center()
              ],
            ),
          ),

        ),
      ),
    );
  }

  _complete_order(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height-MediaQuery.of(context).padding.top,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              _title("complete order"),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 70,
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        payment_shipping=false;
                        billing=false;
                        shipping_and_billing=true;
                      });
                    },
                    child: Row(
                      children: [
                        Checkbox(value: shipping_and_billing, onChanged: (value){
                          setState(() {
                            payment_shipping=false;
                            billing=false;
                            shipping_and_billing=true;
                          });
                        },
                          side: BorderSide(color: Colors.white),
                        ),
                        SizedBox(width: 10,),
                        Text("shipping and billing",style: TextStyle(color: Colors.white,fontSize: 16,),)
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 70,
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        shipping_and_billing=false;
                        payment_shipping=true;
                        billing=false;
                      });
                    },
                    child: Row(
                      children: [
                        Checkbox(value: payment_shipping, onChanged: (value){
                          setState(() {
                            shipping_and_billing=false;
                            payment_shipping=true;
                            billing=false;
                          });
                        },
                          side: BorderSide(color: Colors.white),
                        ),
                        SizedBox(width: 10,),
                        Text("payment shipping",style: TextStyle(color: Colors.white,fontSize: 16,),)
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          Column(
            children: [
              /**submite*/
              Padding(
                padding: const EdgeInsets.only(left: 15,right: 15,top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: (){
                        if(shipping_and_billing){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Billing(1)),
                          );
                        }else{
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Shipping(2)
                            ),
                          );
                        }
                      },
                      child: Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width*0.8,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color:Colors.white,width: 2)
                        ),
                        child: Center(child: Text("Submite",style: TextStyle(color: Colors.white,fontSize: 18),)),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox()
        ],
      ),
    );
  }
  _loading(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height-MediaQuery.of(context).padding.top,
      child:Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
  _title(String title){
    TextStyle text_style=TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold);
    return Padding(
      padding: const EdgeInsets.only(left: 15,right: 15,top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title,style: text_style,),
        ],
      ),
    );
  }
}

