import 'package:chaplin_new_version/controler/connector.dart';
import 'package:chaplin_new_version/controler/story_api.dart';
import 'package:chaplin_new_version/controler/wordpress_connector.dart';
import 'package:chaplin_new_version/model/global.dart';
import 'package:chaplin_new_version/view/dashboard.dart';
import 'package:chaplin_new_version/view/no_internet.dart';
import 'package:chaplin_new_version/view/pick_your_choose.dart';
import 'package:chaplin_new_version/view/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Sign_In extends StatefulWidget {
  const Sign_In({Key? key}) : super(key: key);

  @override
  _Sign_InState createState() => _Sign_InState();
}

class _Sign_InState extends State<Sign_In> {

  bool hidden=true;
  bool _loading = false;
  final email_controller = TextEditingController();
  bool email_vlidate=true;
  final pass_controller = TextEditingController();
  bool pass_vlidate=true;
  final snackBar = SnackBar(content: Text('wrong email or password'));
  final forgetPasswordSnackBar = SnackBar(content: Text('please write your email'));
  final sendPasswordSnackBar = SnackBar(content: Text('your password will be delivered to your email in 2 min please check you email or spam after 2 min'));
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  bool request=true;


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
                        Text("SIGN IN",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)
                      ],
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 20),
                    child: Container(
                      width: MediaQuery.of(context).size.width*0.8,
                      height: 50,
                      child: TextField(
                        controller: email_controller,
                        onChanged: (query){
                          if(query.isNotEmpty){
                          setState(() {
                              email_vlidate=true;
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
                            hintText: 'E-MAIL',
                          errorText: email_vlidate?null:"Email can not be empty",
                          hintStyle: TextStyle(color: Colors.white24,fontSize: 13,fontWeight: FontWeight.bold),


                        ),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 20),
                    child: Container(
                      width: MediaQuery.of(context).size.width*0.8,
                      height: 50,
                      child: TextField(
                        controller: pass_controller,
                        onChanged: (query){
                          if(query.isNotEmpty){
                            setState(() {
                              pass_vlidate=true;
                            });
                          }
                        },
                        obscureText: hidden,
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
                          hintText: 'PASSWORD',
                            errorText: pass_vlidate?null:"Password can not be empty",
                          hintStyle: TextStyle(color: Colors.white24,fontSize: 13,fontWeight: FontWeight.bold),
                          suffixIcon: IconButton(icon: Icon(hidden?Icons.visibility_off_outlined:Icons.remove_red_eye_outlined,color: Colors.white,),onPressed: (){
                            setState(() {
                              hidden=!hidden;
                            });
                          },)
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width*0.8,
                    child: Padding(padding: EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: (){
                              forget_password();
                            },
                            child: Text("forget password",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 14,decoration: TextDecoration.underline),),

                          ),
                        ],
                      ),
                    ),
                  ),

                  Padding(padding: EdgeInsets.only(top: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: (){
                            submit();
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
                              child:  Text("SUBMIT",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("OR",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)
                      ],
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: (){
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
                                // setState(() {
                                //   request=true;
                                // });
                              });
                            });
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
                              child:  Text("visit as guest",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 20),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SignUp()),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Donot have an account?",style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w500,decoration: TextDecoration.underline,),)
                        ],
                      ),
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
  submit(){
    if(email_controller.value.text.isEmpty){
      setState(() {
        email_vlidate=false;
      });
    }
    if(pass_controller.value.text.isEmpty){
      setState(() {
        pass_vlidate=false;
      });
    }
    if(pass_vlidate&&email_vlidate){
      setState(() {
        request=false;
      });
      Connecter.check_internet().then((internet) {
        if(!internet){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NoInternet()),
          ).then((value) {
            submit();
          });
        }else{
          WordPressConnecter.get_customer(email_controller.value.text).then((value) {
            if(value){
              Connecter.log_in(email_controller.value.text, pass_controller.value.text).then((existed) {
                if(existed){
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const DashBoard()),
                  // );
                  StoryApi.get_stories(Global.customer_id).then((value) {
                    StoryApi.get_my_story(Global.customer_id).then((my_story){
                      Navigator.pushReplacement(context,  MaterialPageRoute(builder: (context) => PickChoose(value,my_story)));
                    });
                  });
                }else{
                  setState(() {
                    request=true;
                  });
                  _scaffoldkey.currentState!.showSnackBar(snackBar);
                }
              });
            }else{
              setState(() {
                request=true;
              });
              _scaffoldkey.currentState!.showSnackBar(snackBar);
            }
          });
          // Connecter.log_in(email_controller.value.text, pass_controller.value.text).then((existed) {
          //   if(existed){
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => const DashBoard()),
          //     );
          //   }else{
          //     setState(() {
          //       request=true;
          //     });
          //     _scaffoldkey.currentState!.showSnackBar(snackBar);
          //   }
          // });
        }
      });

    }
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
  forget_password(){
    if(email_controller.value.text.isEmpty){
      setState(() {
        email_vlidate=false;
      });
    }

    if(email_vlidate){
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
            forget_password();
          });
        }else{
          Connecter.forget_password(email_controller.value.text,).then((existed) {
            if(existed){

              setState(() {
                request=true;
              });
              _scaffoldkey.currentState!.showSnackBar(sendPasswordSnackBar);
            }else{
              setState(() {
                request=true;
              });
              _scaffoldkey.currentState!.showSnackBar(forgetPasswordSnackBar);
            }
          });
        }
      });

    }
  }
}
