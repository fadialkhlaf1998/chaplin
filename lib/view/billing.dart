import 'package:chaplin_new_version/controler/connector.dart';
import 'package:chaplin_new_version/controler/wordpress_connector.dart';
import 'package:chaplin_new_version/helper/my_app.dart';
import 'package:chaplin_new_version/model/global.dart';
import 'package:chaplin_new_version/model/order.dart';
import 'package:chaplin_new_version/view/fail.dart';
import 'package:chaplin_new_version/view/no_internet.dart';
import 'package:chaplin_new_version/view/shipping.dart';
import 'package:chaplin_new_version/view/sucss.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Billing extends StatefulWidget {
  int op;

  Billing(this.op);

  @override
  _BillingState createState() => _BillingState(op);
}

class _BillingState extends State<Billing> {
  int op;

  _BillingState(this.op);

  final firstname_controller = TextEditingController();
  bool firstname_vlidate=true;

  final lastname_controller = TextEditingController();
  bool lastname_vlidate=true;


  final email_controller = TextEditingController();
  bool email_vlidate=true;


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

  final snackBar = SnackBar(content: Text('please login first'));
  final confirm_snackBar = SnackBar(content: Text('password not same confirm password'));
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  bool request=true;

  @override
  void initState() {
    get_data();

    super.initState();
  }
  get_data(){
    if(Global.customer!=null){
      if(Global.customer!.billing!.firstName!.isNotEmpty){
        firstname_controller.text=Global.customer!.billing!.firstName!;
      }
      if(Global.customer!.billing!.lastName!.isNotEmpty){
        lastname_controller.text=Global.customer!.billing!.lastName!;
      }
      if(Global.customer!.billing!.email!.isNotEmpty){
        email_controller.text=Global.customer!.billing!.email!;
      }
      if(Global.customer!.billing!.company!.isNotEmpty){
        company_controller.text=Global.customer!.billing!.company!;
      }
      if(Global.customer!.billing!.address1!.isNotEmpty){
        address1_controller.text=Global.customer!.billing!.address1!;
      }
      if(Global.customer!.billing!.address2!.isNotEmpty){
        address2_controller.text=Global.customer!.billing!.address2!;
      }
      if(Global.customer!.billing!.city!.isNotEmpty){
        city_controller.text=Global.customer!.billing!.city!;
      }
      if(Global.customer!.billing!.state!.isNotEmpty){
        state_controller.text=Global.customer!.billing!.state!;
      }
      if(Global.customer!.billing!.country!.isNotEmpty){
        contry_controller.text=Global.customer!.billing!.country!;
      }
      if(Global.customer!.billing!.phone!.isNotEmpty){
        phone_controller.text=Global.customer!.billing!.phone!;
      }

    }

  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
      key: _scaffoldkey,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            Container(
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
                          Text("Billing",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)
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
                                child:  Text("Save",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),),
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
            Padding(
              padding: const EdgeInsets.only(top: 25, left: 20),
              child: GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back_ios,color: Colors.white,size: 28,),
              ),
            ),
          ],
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
    if(email_vlidate &&address1_vlidate&&firstname_vlidate&&
        lastname_vlidate&&address1_vlidate&&city_vlidate&&phone_vlidate&&Global.customer!=null){

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
          Map<String,dynamic> data={

            "shipping": {
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

          };
          WordPressConnecter.put_customer(data,Global.customer!.id!).then((value) {
            if(value){
              print('////////////////*************/////////////');
              if(op==0){
                Navigator.of(context).pop();
              }else if(op==1){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Shipping(1)),
                );
              }else{

              }

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

    }else if(Global.customer==null){
      // _scaffoldkey.currentState!.showSnackBar(snackBar);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
  create_order(){
    Order order=Order();
    order.lineItems=<LineItem>[];
    for(int i=0;i<Global.my_order.length;i++){
      print(Global.my_order[i].product!.id);
      order.lineItems!
          .add(LineItem.constructor(
          Global.my_order[i].product!.id,
          Global.my_order[i].count!));
    }
    order.shipping=Global.customer!.shipping;
    order.billing=Global.customer!.billing;
    //ToDo ask adel for that
    order.setPaid=true;
    order.paymentMethod="bacs";
    order.paymentMethod="Direct Bank Transfer";
    setState(() {
      request=true;
    });
    WordPressConnecter.post_order(order.toMap()).then((deliver) {

      if(deliver){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Sucss()),
        );

      }else{
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Fail()),
        );

      }
    });
  }
}

