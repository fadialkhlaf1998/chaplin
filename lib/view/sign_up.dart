import 'package:chaplin_new_version/controler/connector.dart';
import 'package:chaplin_new_version/controler/wordpress_connector.dart';
import 'package:chaplin_new_version/model/global.dart';
import 'package:chaplin_new_version/view/no_internet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  bool hidden=true;
  bool con_hidden=true;
  final firstname_controller = TextEditingController();
  bool firstname_vlidate=true;

  final lastname_controller = TextEditingController();
  bool lastname_vlidate=true;


  final email_controller = TextEditingController();
  bool email_vlidate=true;

  final pass_controller = TextEditingController();
  bool pass_vlidate=true;

  final conpass_controller = TextEditingController();
  bool conpass_vlidate=true;

  final company_controller = TextEditingController();

  final address1_controller = TextEditingController();
  bool address1_vlidate=true;

  final address2_controller = TextEditingController();

  final city_controller = TextEditingController();
  bool city_vlidate=true;

  final state_controller = TextEditingController();

  final contry_controller = TextEditingController();

  final phone_controller = TextEditingController();
  bool phone_vlidate=true;

  bool confirm=true;
  final snackBar = SnackBar(content: Text('please change email'));
  final confirm_snackBar = SnackBar(content: Text('password not same confirm password'));
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
                      Text("SIGN UP",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width*0.8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(padding: EdgeInsets.only(top: 20),
                        child: Container(
                          width: MediaQuery.of(context).size.width*0.35,
                          height: 50,
                          child: TextField(
                            controller: firstname_controller,
                            onChanged: (query){
                              if(query.isNotEmpty){
                                setState(() {
                                  firstname_vlidate=true;
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
                              hintText: 'FIRST NAME',
                              errorText: firstname_vlidate?null:"First name can not be empty",
                              hintStyle: TextStyle(color: Colors.white24,fontSize: 13,fontWeight: FontWeight.bold),

                            ),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 20),
                        child: Container(
                          width: MediaQuery.of(context).size.width*0.35,
                          height: 50,
                          child: TextField(
                            controller: lastname_controller,
                            onChanged: (query){
                              if(query.isNotEmpty){
                                setState(() {
                                  lastname_vlidate=true;
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
                              hintText: 'LAST NAME',
                              errorText: lastname_vlidate?null:"Last name can not be empty",
                              hintStyle: TextStyle(color: Colors.white24,fontSize: 13,fontWeight: FontWeight.bold),

                            ),
                          ),
                        ),
                      ),
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
                          errorText: pass_vlidate?null:"Email can not be empty",
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
                Padding(padding: EdgeInsets.only(top: 20),
                  child: Container(
                    width: MediaQuery.of(context).size.width*0.8,
                    height: 50,
                    child: TextField(
                      controller: conpass_controller,
                      onChanged: (query){
                        if(query.isNotEmpty){
                          setState(() {
                            conpass_vlidate=true;
                          });
                        }
                      },
                      obscureText: con_hidden,
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
                          hintText: 'CONFIRM PASSWORD',
                          errorText: conpass_vlidate?null:"Email can not be empty",
                          hintStyle: TextStyle(color: Colors.white24,fontSize: 13,fontWeight: FontWeight.bold),
                          suffixIcon: IconButton(icon: Icon(con_hidden?Icons.visibility_off_outlined:Icons.remove_red_eye_outlined,color: Colors.white,),onPressed: (){
                            setState(() {
                              con_hidden=!con_hidden;
                            });
                          },)
                      ),
                    ),
                  ),
                ),
                /**company*/
                Padding(padding: EdgeInsets.only(top: 20),
                  child: Container(
                    width: MediaQuery.of(context).size.width*0.8,
                    height: 50,
                    child: TextField(
                      controller: company_controller,

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
                        hintText: 'COMPANY',
                        hintStyle: TextStyle(color: Colors.white24,fontSize: 13,fontWeight: FontWeight.bold),

                      ),
                    ),
                  ),
                ),

                /**address 1*/
                Padding(padding: EdgeInsets.only(top: 20),
                  child: Container(
                    width: MediaQuery.of(context).size.width*0.8,
                    height: 50,
                    child: TextField(
                      controller: address1_controller,
                      onChanged: (query){
                        if(query.isNotEmpty){
                          setState(() {
                            address1_vlidate=true;
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
                          hintText: 'Address 1',
                          errorText: address1_vlidate?null:"Address 1 can not be empty",
                          hintStyle: TextStyle(color: Colors.white24,fontSize: 13,fontWeight: FontWeight.bold),

                      ),
                    ),
                  ),
                ),

                /**address 2*/
                Padding(padding: EdgeInsets.only(top: 20),
                  child: Container(
                    width: MediaQuery.of(context).size.width*0.8,
                    height: 50,
                    child: TextField(
                      controller: address2_controller,

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
                        hintText: 'Address 2',

                        hintStyle: TextStyle(color: Colors.white24,fontSize: 13,fontWeight: FontWeight.bold),

                      ),
                    ),
                  ),
                ),

                /**city*/
                Padding(padding: EdgeInsets.only(top: 20),
                  child: Container(
                    width: MediaQuery.of(context).size.width*0.8,
                    height: 50,
                    child: TextField(
                      controller: city_controller,
                      onChanged: (query){
                        if(query.isNotEmpty){
                          setState(() {
                            city_vlidate=true;
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
                        hintText: 'CITY',
                        errorText: city_vlidate?null:"City can not be empty",
                        hintStyle: TextStyle(color: Colors.white24,fontSize: 13,fontWeight: FontWeight.bold),

                      ),
                    ),
                  ),
                ),

                /**state*/
                Padding(padding: EdgeInsets.only(top: 20),
                  child: Container(
                    width: MediaQuery.of(context).size.width*0.8,
                    height: 50,
                    child: TextField(
                      controller: state_controller,

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
                        hintText: 'State',

                        hintStyle: TextStyle(color: Colors.white24,fontSize: 13,fontWeight: FontWeight.bold),

                      ),
                    ),
                  ),
                ),

                /**country*/
                Padding(padding: EdgeInsets.only(top: 20),
                  child: Container(
                    width: MediaQuery.of(context).size.width*0.8,
                    height: 50,
                    child: TextField(
                      controller: contry_controller,

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
                        hintText: 'COUNTRY',

                        hintStyle: TextStyle(color: Colors.white24,fontSize: 13,fontWeight: FontWeight.bold),

                      ),
                    ),
                  ),
                ),

                /**phone*/
                Padding(padding: EdgeInsets.only(top: 20),
                  child: Container(
                    width: MediaQuery.of(context).size.width*0.8,
                    height: 50,
                    child: TextField(
                      controller: phone_controller,
                      onChanged: (query){
                        if(query.isNotEmpty){
                          setState(() {
                            phone_vlidate=true;
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
                        hintText: 'PHONE',
                        errorText: phone_vlidate?null:"Phone can not be empty",
                        hintStyle: TextStyle(color: Colors.white24,fontSize: 13,fontWeight: FontWeight.bold),

                      ),
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
                            child:  Text("Create account",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),),
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

    if(firstname_controller.value.text.isEmpty){
      setState(() {
        firstname_vlidate=false;
      });
    }
    if(lastname_controller.value.text.isEmpty){
      setState(() {
        lastname_vlidate=false;
      });
    }
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

    if(conpass_controller.value.text.isEmpty){
      setState(() {
        conpass_vlidate=false;
      });
    }
    if(conpass_controller.value.text!=pass_controller.value.text){
      setState(() {
        confirm=false;
      });
      // _scaffoldkey.currentState!.showSnackBar(confirm_snackBar);
      ScaffoldMessenger.of(context).showSnackBar(confirm_snackBar);
    }
    if(address1_controller.value.text.isEmpty){
      setState(() {
        address1_vlidate=false;
      });
    }
    if(city_controller.value.text.isEmpty){
      setState(() {
        city_vlidate=false;
      });
    }
    if(phone_controller.value.text.isEmpty){
      setState(() {
        phone_vlidate=false;
      });
    }
    if(email_vlidate&&pass_vlidate&&conpass_vlidate&&confirm
    &&address1_vlidate&&firstname_vlidate&&lastname_vlidate&&address1_vlidate&&city_vlidate&&phone_vlidate){

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
          /*
          print(firstname_controller.value.text);
          print(lastname_controller.value.text);
          print(email_controller.value.text);
          print(username_controller.value.text);
          print(phone_controller.value.text);
          print(company_controller.value.text);
          print(contry_controller.value.text);
          print(address1_controller.value.text);
          print(address2_controller.value.text);
          print(city_controller.value.text);
          print(state_controller.value.text);*/
          Global.email=email_controller.value.text;
          Global.password=pass_controller.value.text;
          Map<String,dynamic> data={
          "firstName":firstname_controller.value.text,
          "lastName": lastname_controller.value.text,
          "email": email_controller.value.text,
          //"username": username_controller.value.text,
          "billing": {
          "first_name":firstname_controller.value.text,
          "last_name": lastname_controller.value.text,
          "email": email_controller.value.text,
          "phone": phone_controller.value.text,
          "company": company_controller.value.text,
          "country": contry_controller.value.text,
          "address_1": address1_controller.value.text,
          "address_2": address2_controller.value.text,
          "city": city_controller.value.text,
          "state": state_controller.value.text
          },
          "shipping": {

          "firstName":firstname_controller.value.text,
          "lastName": lastname_controller.value.text,
          "company": company_controller.value.text,
          "country": contry_controller.value.text,
          "address1": address1_controller.value.text,
          "address2": address2_controller.value.text,
          "city": city_controller.value.text,
          "state": state_controller.value.text
          }
          };
          WordPressConnecter.post_customer(data).then((value) {
            if(value){
              Connecter.sign_up(email_controller.value.text, pass_controller.value.text,firstname_controller.value.text,lastname_controller.value.text).then((signed) {
                if(signed){
                  Navigator.pushNamedAndRemoveUntil(context, "code", (r) => false);
                }else{
                  print('666666666666666666666');
                  setState(() {
                    request=true;
                  });
                  // _scaffoldkey.currentState!.showSnackBar(snackBar);
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              });

            }else{
              setState(() {
                request=true;
              });
              final snackBar_2= SnackBar(content: Text('some thing went wrong'));
              // _scaffoldkey.currentState!.showSnackBar(snackBar_2);
              ScaffoldMessenger.of(context).showSnackBar(snackBar_2);
            }

          });


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
}
