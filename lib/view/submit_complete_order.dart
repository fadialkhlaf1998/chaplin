import 'package:chaplin_new_version/controler/connector.dart';
import 'package:chaplin_new_version/controler/story_api.dart';
import 'package:chaplin_new_version/controler/wordpress_connector.dart';
import 'package:chaplin_new_version/helper/my_app.dart';
import 'package:chaplin_new_version/model/global.dart';
import 'package:chaplin_new_version/model/order.dart';
import 'package:chaplin_new_version/view/billing.dart';
import 'package:chaplin_new_version/view/dashboard.dart';
import 'package:chaplin_new_version/view/fail.dart';
import 'package:chaplin_new_version/view/my_fatoorah.dart';
import 'package:chaplin_new_version/view/pick_your_choose.dart';
import 'package:chaplin_new_version/view/shipping.dart';
import 'package:chaplin_new_version/view/sucss.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class SubmitCompleteOrder extends StatefulWidget {
  const SubmitCompleteOrder({Key? key}) : super(key: key);

  @override
  _SubmitCompleteOrderState createState() => _SubmitCompleteOrderState();
}

class _SubmitCompleteOrderState extends State<SubmitCompleteOrder> {
  int page=0;

  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  bool loading=false;
  final snackBar_succc = SnackBar(content: Text('order completed'));
  final snackBar_fail = SnackBar(content: Text("some thing went wrong"));

  bool? validate = false;

  TextEditingController _tableNumberSubmit = TextEditingController();
  TextEditingController _description = TextEditingController();

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
      //height: MediaQuery.of(context).size.height -MediaQuery.of(context).padding.top - 50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              SizedBox(height: 30,),
              _title("complete order"),
              SizedBox(height: 30,),
              _TableNumberInfoSubmit(),
              SizedBox(height: 50),
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
                      onTap: ()async{
                        Global.table_number = _tableNumberSubmit.text;
                        Global.description = _description.text;
                        setState(() {
                          _tableNumberSubmit.text.isEmpty ? validate = true : validate = false;
                        });
                        if (validate == false){
                          Connecter.send_email(_tableNumberSubmit.text);
                        }
                        App.succ_msg(context, 'Your order submit successfully');
                        StoryApi.get_stories(Global.customer_id).then((value) {
                          StoryApi.get_my_story(Global.customer_id).then((my_story){
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (BuildContext context) => PickChoose(value, my_story)),
                                  (route) => false,
                            );
                            // setState(() {
                            //   request=true;
                            // });
                          });
                        });
                      },
                      child: Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width*0.6,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color:Colors.white,width: 2)
                        ),
                        child: Center(child: Text("Submite",style: TextStyle(color: Colors.white,fontSize: 20),)),
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


  _TableNumberInfoSubmit(){
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          padding: EdgeInsets.only(left: 15,right: 15,top: 20),
          child: TextField(
            controller: _tableNumberSubmit,
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(color: Colors.white, width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(color: Colors.white, width: 1),
              ),
              labelText: 'Enter table number',
              labelStyle: validate == true ? TextStyle(color: Colors.red) : TextStyle(color: Colors.white.withOpacity(0.5)),
              errorText: validate == true ? 'Value can\'t Be Empty' : null,
            ),
          ),
        ),
        SizedBox(height: 10),
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.width * 0.4,
          padding: EdgeInsets.only(left: 15,right: 15,top: 20),
          child: TextField(
            controller: _description,
            maxLines: 10,
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(color: Colors.white, width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(color: Colors.white, width: 1),
              ),
              labelText: 'Enter your opinion',
              labelStyle: TextStyle(color: Colors.white.withOpacity(0.5)),

            ),
          ),
        ),
      ],
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

