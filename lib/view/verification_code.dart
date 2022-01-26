import 'dart:async';
import 'dart:math';

import 'package:chaplin_new_version/controler/connector.dart';
import 'package:chaplin_new_version/controler/setting.dart';
import 'package:chaplin_new_version/controler/story_api.dart';
import 'package:chaplin_new_version/controler/wordpress_connector.dart';
import 'package:chaplin_new_version/model/global.dart';
import 'package:chaplin_new_version/view/dashboard.dart';
import 'package:chaplin_new_version/view/no_internet.dart';
import 'package:chaplin_new_version/view/pick_your_choose.dart';
import 'package:chaplin_new_version/view/sign_up.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

class VerificationCode extends StatefulWidget {
  const VerificationCode({Key? key}) : super(key: key);

  @override
  _VerificationCodeState createState() => _VerificationCodeState();
}

class _VerificationCodeState extends State<VerificationCode> {

  bool hidden=true;
  final username_controller = TextEditingController();
  bool username_vlidate=true;

  final snackBar = SnackBar(content: Text('email is existed'));
  final confirm_snackBar = SnackBar(content: Text('password not same confirm password'));
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  bool request=true;
  bool end_time=false;
  DateTime dateTime=DateTime.now().add(Duration(minutes: 2));
  @override
  void initState() {
    super.initState();
    String date=Global.timer;
    if(date!="non"){
      dateTime=DateTime.parse(date);
      if(dateTime.isBefore(DateTime.now())){
        setState(() {
          end_time=true;
        });
      }
    }
    AppSetting.set_timer(dateTime.toString());
    AppSetting.load();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
      key: _scaffoldkey,
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              color: Colors.black87,
              image: DecorationImage(
                  image: AssetImage("assets/login.png"),
                  fit: BoxFit.cover
              )
          ),
          //color: Colors.black87,
          child: SingleChildScrollView(
            child:
            !request?
            loading()
                :Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*0.35,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      image: DecorationImage(
                          image: AssetImage("assets/logo.png"),
                          fit: BoxFit.none
                      )
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Verification code",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 20),
                  child: Container(
                    width: MediaQuery.of(context).size.width*0.8,
                    height: 50,
                    child: TextField(
                      controller: username_controller,
                      onChanged: (query){
                        if(query.isNotEmpty){
                          setState(() {
                            username_vlidate=true;
                          });
                        }
                      },
                      textAlignVertical: TextAlignVertical.bottom,
                      style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold,fontFamily: "RedHand"),
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        hintText: 'CODE',
                        errorText: username_vlidate?null:"code can not be empty",
                        hintStyle: TextStyle(color: Colors.white,fontSize: 13,fontWeight: FontWeight.bold),

                      ),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 20),
                  child: Container(
                    width: MediaQuery.of(context).size.width*0.8,
                    height: 120,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("please check your email for code or ",style: TextStyle(color: Colors.white),),
                            GestureDetector(
                              onTap: (){
                                if(end_time)
                                reSend();

                                },
                              child: !end_time?
                                   Text("resend",style: TextStyle(color: Colors.grey
                                  ,decoration:TextDecoration.underline,fontWeight: FontWeight.bold),)
                                  :Text("resend",style: TextStyle(color: Colors.white
                                  ,decoration:TextDecoration.underline,fontWeight: FontWeight.bold),),
                            )
                          ],
                        ),
                        SizedBox(height: 10,),
                        Text("this operation take some time",style: TextStyle(color: Colors.white),),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Your email is "+Global.email+" or ",style: TextStyle(color: Colors.white),),
                            GestureDetector(
                              onTap: (){
                                 AppSetting.set_timer("non");
                                 AppSetting.set_verificated(false);
                                 AppSetting.save("non", "non");
                                 Navigator.pushReplacement(
                                   context,
                                   MaterialPageRoute(builder: (context) => SignUp()),
                                 );
                              },
                              child:Text("edit",style: TextStyle(color: Colors.white
                                  ,decoration:TextDecoration.underline,fontWeight: FontWeight.bold),),
                            )
                          ],
                        ),
                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            !end_time?
                            CountdownTimer(
                              endTime: dateTime.millisecondsSinceEpoch + 1000,
                              onEnd: (){
                                setState(() {
                                  end_time=true;
                                });
                              },
                              textStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 35,color: Colors.white),
                            ):Center(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),


                Padding(padding: EdgeInsets.only(top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: (){
                          createAccount();

                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width*0.8,
                          height: 60,

                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.all(Radius.circular(75)),
                            border: Border.all(color: Colors.white,width: 2),
                          ),
                          child:Center(
                            child:  Text("Done",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 15,
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
  createAccount(){


    if(username_controller.value.text.isEmpty){
      setState(() {
        username_vlidate=false;
      });
    }

    if(username_vlidate){

      setState(() {
        request=false;
      });
      Connecter.check_internet().then((internet) {
        print(internet);
        if(!internet){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NoInternet()),
          ).then((value) {
            createAccount();
          });
        }else{
          print(Global.email);
          print(Global.password);
          print(username_controller.value.text);
          Connecter.code_verification(Global.email, Global.password,username_controller.value.text).then((verify) {
            if(verify){
              Connecter.log_in(Global.email, Global.password);
              WordPressConnecter.get_customer(Global.email).then((value) {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => const DashBoard()),
                // );
                setState(() {
                  request=false;
                });
                StoryApi.get_stories(Global.customer_id).then((value) {
                  StoryApi.get_my_story(Global.customer_id).then((my_story){
                    Navigator.pushReplacement(context,  MaterialPageRoute(builder: (context) => PickChoose(value,my_story)));
                    setState(() {
                      request=true;
                    });
                  });
                });
              });

            }else{
              setState(() {
                request=true;
              });
              _scaffoldkey.currentState!.showSnackBar(snackBar);
            }
          });
        }
      });

    }
  }

  reSend(){
    Connecter.check_internet().then((internet) {
      print(internet);
      if(!internet){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NoInternet()),
        ).then((value) {
          reSend();
        });
      }else{
        Connecter.resend_code(Global.email).then((existed) {
          if(existed){
            setState(() {
              end_time=false;
            });
            dateTime=DateTime.now().add(Duration(minutes: 2));
            AppSetting.set_timer(dateTime.toString());
          }else{
            setState(() {
              request=true;
            });
            _scaffoldkey.currentState!.showSnackBar(snackBar);
          }
        });
      }
    });
  }

  loading(){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: Colors.white,)
        ],
      ),
    );
  }
}
