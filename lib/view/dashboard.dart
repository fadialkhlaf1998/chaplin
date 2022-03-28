import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:chaplin_new_version/controler/connector.dart';
import 'package:chaplin_new_version/controler/setting.dart';
import 'package:chaplin_new_version/controler/store.dart';
import 'package:chaplin_new_version/controler/story_api.dart';
import 'package:chaplin_new_version/controler/wordpress_connector.dart';
import 'package:chaplin_new_version/helper/app_localization.dart';
import 'package:chaplin_new_version/main.dart';
import 'package:chaplin_new_version/model/category.dart';
import 'package:chaplin_new_version/model/global.dart';
import 'package:chaplin_new_version/model/product.dart';
import 'package:chaplin_new_version/view/billing.dart';
import 'package:chaplin_new_version/view/favorite.dart';
import 'package:chaplin_new_version/view/item.dart';
import 'package:chaplin_new_version/view/no_internet.dart';
import 'package:chaplin_new_version/view/photo_picker.dart';
import 'package:chaplin_new_version/view/pick_your_choose.dart';
import 'package:chaplin_new_version/view/qr_scanner.dart';
import 'package:chaplin_new_version/view/shipping.dart';
import 'package:chaplin_new_version/view/sign_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';


class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard>{
  int selder_selected = 0;
  int selected_category = 0;
  int count = 0;
  double total = 0;
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  final snackBar = SnackBar(content: Text('your product added to cart'));
  final must_login_snackBar = SnackBar(content: Text('you must login first'));
  bool music_poked=true;
  bool loading=false;
  bool show = true;
  bool isPress = true;
  Timer? _timer;
  int start_timer = 0;
  List<ProductCategory> categories=<ProductCategory>[];
  List<Product> products=<Product>[];
  ScrollController _scrollController = ScrollController();

  /**test*/
  int bottom_sheet_price=2;
  var imageList=["assets/dashboard/categiory_3.png","assets/dashboard/categiory_2.png","assets/dashboard/categiory_5.png",
  "assets/dashboard/categiory_4.png","assets/dashboard/categiory_1.png"];
  get_search(String query){
    setState(() {
      loading=true;
      WordPressConnecter.get_products_search(query).then((value){
        products=value;
        selected_category=-1;
        setState(() {
          loading=false;
        });

      }).catchError((err){
        print(err);
        loading=false;
      });
    });
  }

  late AnimationController iconController;

  @override
  void initState() {
    super.initState();
    show = false;

  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    get_category();
    return Scaffold(
      backgroundColor: Color(0xff272525),
      key: _scaffoldkey,
      drawer: Drawer(
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/sidebar_cover.png"),
                  fit: BoxFit.cover
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: Container(
                          width: MediaQuery.of(context).size.width*0.3,
                          height: MediaQuery.of(context).size.width*0.3,
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              shape: BoxShape.circle
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(App_Localization.of(context)!.translate("charlie_chaplin"),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                      )
                    ],
                  ),
                  Divider(thickness: 1,color: Colors.black,endIndent: 100, indent: 100,),
                  /*
                                    Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 4,
                          width: 40,
                          color: Colors.black87,
                        ),
                        GestureDetector(
                          onTap: (){
                            if(Global.customer==null){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const Sign_In()),
                              );
                            }else{
                              setState(() {
                                StoryApi.get_stories(Global.customer_id).then((value) {
                                  StoryApi.get_my_story(Global.customer_id).then((my_story){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => PhotoPicker(value,my_story)),
                                    );
                                  });

                                });
                              });
                            }
                          },
                          child: Padding(padding: EdgeInsets.only(left: 15,right: 15),
                            child: Text(App_Localization.of(context)!.translate("profile"),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                          ),
                        ),
                        Container(
                          height: 4,
                          width: 40,
                          color: Colors.black87,
                        ),
                      ],
                    ),
                  ),


                   */
                  Global.customer == null ?
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.pushNamedAndRemoveUntil(context, "signIn", (r) => false);
                          },
                          child: Padding(padding: EdgeInsets.only(left: 15,right: 15),
                            child: Text('Login',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                          ),
                        ),
                      ],
                    ),
                  ) : Center(),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Favorite()),
                            );
                          },
                          child: Padding(padding: EdgeInsets.only(left: 15,right: 15),
                            child: Text(App_Localization.of(context)!.translate("favorite"),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: (){
                            if(Global.customer!=null){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Shipping(0)),
                              );
                            }else{
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Billing(0)),
                              );
                              // _scaffoldkey.currentState!.showSnackBar(must_login_snackBar);
                            }
                          },
                          child: Padding(padding: EdgeInsets.only(left: 15,right: 15),
                            child: Text(App_Localization.of(context)!.translate("my_address"),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: (){
                            AppSetting.set_verificated(false);
                            AppSetting.save("non", "non");
                            AppSetting.set_timer("non");
                            Global.customer=null;
                            Global.customer_id=-1;
                            Navigator.pushNamedAndRemoveUntil(context, "signIn", (r) => false);
                          },
                          child: Padding(padding: EdgeInsets.only(top: 20,left: 20,right: 20),
                            child: Global.customer==null?Center():Text(App_Localization.of(context)!.translate("logout"),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 20,left: 20,right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(onPressed: ()async{
                          //todo nav to instgram
                          if( await canLaunch("https://www.instagram.com/chaplin_uae?utm_medium=copy_link")){
                            await launch("https://www.instagram.com/chaplin_uae?utm_medium=copy_link");
                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Can not open Instagram")));
                          }
                        }, icon: const ImageIcon(
                          AssetImage("assets/social-media/insta.png"),
                          size: 40,
                        )),
                        // IconButton(onPressed: (){
                        //   //todo nav to twitter
                        // }, icon: const ImageIcon(
                        //   AssetImage("assets/social-media/twitter.png"),
                        //   size: 40,
                        // )),
                        IconButton(
                            onPressed: ()async{
                              //todo nav to facebook
                              if( await canLaunch("https://m.facebook.com/chaplindubai/")){
                                await launch("https://m.facebook.com/chaplindubai/");
                              }else{
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Can not open facebook")));
                              }
                            }, icon: const ImageIcon(
                          AssetImage("assets/social-media/facebook.png"),
                          size: 40,
                        )),
                        IconButton(onPressed: ()async{
                          //todo nav to youtube
                          if( await canLaunch("https://vm.tiktok.com/ZSeV9XSK2/")){
                            await launch("https://vm.tiktok.com/ZSeV9XSK2/");
                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Can not open facebook")));
                          }
                        }, icon: const ImageIcon(
                          AssetImage("assets/social-media/tik-tok.png",),
                          size: 20,
                        )),

                      ],
                    ),
                  ),
                  // Padding(padding: EdgeInsets.only(top: 20),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //     children: [
                  //       SizedBox(width: MediaQuery.of(context).size.width*0.1,),
                  //       GestureDetector(
                  //         child: Text(App_Localization.of(context)!.translate("privace_policy"),style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                  //         onTap: (){
                  //           // Todo : nav
                  //         },
                  //       ),
                  //       Text("."),
                  //       GestureDetector(
                  //         child: Text(App_Localization.of(context)!.translate("term_of_sale"),style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                  //         onTap: (){
                  //           // Todo : nav
                  //         },
                  //       ),
                  //       Text("."),
                  //       GestureDetector(
                  //         child: Text(App_Localization.of(context)!.translate("term_of_use"),style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                  //         onTap: (){
                  //           // Todo : nav
                  //         },
                  //       ),
                  //       SizedBox(width: MediaQuery.of(context).size.width*0.1,),
                  //     ],
                  //   ),
                  // ),
                  // Padding(padding: EdgeInsets.only(top: 10),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //     children: [
                  //       SizedBox(width: MediaQuery.of(context).size.width*0.1,),
                  //       GestureDetector(
                  //         child: Text(App_Localization.of(context)!.translate("return_policy"),style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                  //         onTap: (){
                  //           // Todo : nav
                  //         },
                  //       ),
                  //       Text("."),
                  //       GestureDetector(
                  //         child: Text(App_Localization.of(context)!.translate("warranty_policy"),style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                  //         onTap: (){
                  //           // Todo : nav
                  //         },
                  //       ),
                  //
                  //
                  //
                  //       SizedBox(width: MediaQuery.of(context).size.width*0.1,),
                  //     ],
                  //   ),
                  // ),
                  Padding(padding: EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(App_Localization.of(context)!.translate("version"),style: TextStyle(fontSize: 10,color: Colors.grey),),
                      ],
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(App_Localization.of(context)!.translate("rights"),style: TextStyle(fontSize: 8,color: Colors.black,),),
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height*0.1,
                    width: MediaQuery.of(context).size.width*0.5,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/black_logo.png",),
                            fit: BoxFit.cover
                        )
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    //SizedBox(height: MediaQuery.of(context).size.height * 0.2<=160?240:MediaQuery.of(context).size.height * 0.2,),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.35),
                    Container(
                      color: Color(0xff272525),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, top: 15),
                            child: Row(
                              children: [
                                Text(
                                  selected_category==-1?App_Localization.of(context)!.translate("search"):categories.isNotEmpty?categories[selected_category].name!:App_Localization.of(context)!.translate("categories"),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          loading?_loading():this.products.length!=0?Container(
                            width: MediaQuery.of(context).size.width,
                              constraints: BoxConstraints(
                                minHeight: MediaQuery.of(context).size.height*0.5
                              ),
                            child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: MediaQuery.of(context).size.width>=768?2:1,
                              crossAxisSpacing: 15.0,
                              mainAxisSpacing: 5.0,
                              mainAxisExtent: MediaQuery.of(context).size.height>600? MediaQuery.of(context).size.height * 0.2+MediaQuery.of(context).size.width*0.075: MediaQuery.of(context).size.height * 0.3+MediaQuery.of(context).size.width*0.075//MediaQuery.of(context).size.height>600? MediaQuery.of(context).size.height * 0.18: MediaQuery.of(context).size.height * 0.21
                            ),
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: this.products.length,
                                itemBuilder: (context,index){
                                return Stack(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                              Item(this.products[index])),
                                        ).then((value) {
                                          _calc_total();
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15,
                                            right: 15,
                                            top: 10,
                                            bottom: 0),
                                        child: Container(
                                          height:MediaQuery.of(context).size.height>600? MediaQuery.of(context).size.height * 0.2+MediaQuery.of(context).size.width*0.075: MediaQuery.of(context).size.height * 0.3+MediaQuery.of(context).size.width*0.075,//MediaQuery.of(context).size.height>600? MediaQuery.of(context).size.height * 0.18: MediaQuery.of(context).size.height * 0.21,
                                          color: Colors.transparent,
                                          child: Center(
                                            child: Container(
                                              width: MediaQuery.of(context).size.width *0.9,
                                              height: MediaQuery.of(context).size.height>600? MediaQuery.of(context).size.height * 0.2: MediaQuery.of(context).size.height * 0.3,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                BorderRadius.circular(10),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child:  Padding(
                                                      padding: const EdgeInsets.only(right: 10),
                                                      child: Container(
                                                      width:MediaQuery.of(context).size.height>600? MediaQuery.of(context).size.height * 0.5: MediaQuery.of(context).size.height *  0.5,
                                                      height:MediaQuery.of(context).size.height>600? MediaQuery.of(context).size.height * 0.5: MediaQuery.of(context).size.height *  0.5,
                                                      decoration: BoxDecoration(
                                                          borderRadius:BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10)),
                                                        image: DecorationImage(
                                                          image: NetworkImage(this.products[index].images!.first.src!),
                                                          fit: BoxFit.cover,
                                                        )
                                                      ),
                                                      // child: this.products[index].images!.isNotEmpty?
                                                      // Image.network(
                                                      //   this.products[index].images!.first.src!,
                                                      //   width:MediaQuery.of(context).size.height>600? MediaQuery.of(context).size.height * 0.08: MediaQuery.of(context).size.height * 0.12)
                                                      //   :Icon(Icons.food_bank_outlined,color: Colors.black87,),
                                                  ),
                                                    ),),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(left: 5),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          SizedBox(height: 10),
                                                          Container(
                                                            height: 18,
                                                            child: Text(
                                                              this.products[index].name!,
                                                              style: TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                  FontWeight.bold,
                                                                overflow: TextOverflow.ellipsis
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                              child: Center(
                                                                  child:  Html(
                                                                    data: this.products[index].description!,
                                                                    style: {
                                                                      "body" : Style(fontSize: FontSize(13), maxLines: 3)
                                                                    },
                                                                  ),
                                                              )),
                                                          Column(
                                                            crossAxisAlignment:CrossAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                App_Localization.of(context)!.translate("aed")+" "+this.products[index].price!,
                                                                style: TextStyle(
                                                                    fontSize: 16,
                                                                    fontWeight:FontWeight.bold,
                                                                    color: Colors.red),
                                                              ),
                                                               SizedBox(height: 10),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        bottom: 10,),
                                                    child: Column(
                                                      mainAxisAlignment:MainAxisAlignment.end,
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              show = true;
                                                              start_timer = 0;
                                                              _timer?.cancel();
                                                            });
                                                            _timer = new Timer.periodic(
                                                                Duration(seconds: 1),
                                                                    (Timer timer){
                                                                  if(start_timer == 3){
                                                                    setState(() {
                                                                      show = false;
                                                                      timer.cancel();
                                                                    });
                                                                  }else {
                                                                    setState(() {
                                                                      start_timer ++;
                                                                    });
                                                                  }
                                                                }
                                                            );

                                                            Global.add_to_order(this.products[index], 1);
                                                            _calc_total();
                                                          },
                                                          child: Container(
                                                            margin: EdgeInsets.only(left: 10,right: 10),
                                                            height: 35,
                                                            width: 35,
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .black87,
                                                                shape: BoxShape
                                                                    .circle),
                                                            child: Icon(
                                                              Icons
                                                                  .shopping_cart_outlined,
                                                              color: Colors
                                                                  .white,
                                                              size: 20,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                        right: MediaQuery.of(context).size.width>=768?MediaQuery.of(context).size.width*0.0125/2:MediaQuery.of(context).size.width*0.025,
                                        top: MediaQuery.of(context).size.width>=768?MediaQuery.of(context).size.width*0.015:0,//MediaQuery.of(context).size.height>1000?0:MediaQuery.of(context).size.width*0.03,
                                        child: Container(
                                          width: MediaQuery.of(context).size.width>=768?MediaQuery.of(context).size.width*0.05:MediaQuery.of(context).size.width*0.1,
                                          height: MediaQuery.of(context).size.width>=768?MediaQuery.of(context).size.width*0.05:MediaQuery.of(context).size.width*0.1,
                                          child: Container(
                                            child: Image.asset(
                                              "assets/chapo.png",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        )),
                                  ],
                                );
                            })
                          )
                          :Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height*0.5,
                            color: Colors.transparent,
                            child: Center(
                              child: Text(App_Localization.of(context)!.translate("oops_no_elms"),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.08,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
                child: Stack(
              children: [
                Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.115 ),
                    categories.isNotEmpty?Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.25<=160?150:MediaQuery.of(context).size.height * 0.2,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          image: DecorationImage(
                              image: AssetImage(
                                "assets/dashboard/background_list.png",
                              ),
                              fit: BoxFit.cover)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.05<40?50:MediaQuery.of(context).size.height * 0.06,
                            child: Padding(
                              padding:
                              EdgeInsets.only(left: 15, right: 15, top: 25),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    App_Localization.of(context)!.translate("categories"),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  /*Text(
                                    App_Localization.of(context)!.translate("offers"),
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),*/
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 0, right: 0),
                            child: Container(
                              height:  MediaQuery.of(context).size.height * 0.15<99?99:MediaQuery.of(context).size.height * 0.12,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                              ),
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount:categories.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selected_category = index;
                                          _scrollController.animateTo(
                                              _scrollController.position.minScrollExtent,
                                              duration: Duration(milliseconds: 500),
                                              curve: Curves.ease);
                                        });
                                        get_product();
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                                        width:MediaQuery.of(context).size.height *0.09,
                                        height:MediaQuery.of(context).size.height * 0.1,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(10),
                                            // BoxShape.circle or BoxShape.retangle
                                            color: selected_category == index ? Color(0xff272525) : Colors.white,
                                            boxShadow: [
                                              MediaQuery.of(context).size.width<768?
                                              selected_category!=index?
                                              BoxShadow(
                                                color: Color(0xffe1e1e1),
                                                blurRadius: 5,
                                              ):BoxShadow(
                                                color: Color(0xffe1e1e1).withOpacity(0.0),
                                                blurRadius: 5,
                                              ):BoxShadow(
                                                color: Color(0xffe1e1e1).withOpacity(0.0),
                                                blurRadius: 5,
                                              ),
                                            ]),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context).size.height *0.08,
                                              height: MediaQuery.of(context).size.height *0.06,
                                              child: categories[index].image!=null
                                                  ? ClipRRect(
                                                borderRadius: BorderRadius.circular(7),
                                                    child: SvgPicture.network(
                                                      categories[index].image!,
                                                      fit: BoxFit.contain,
                                                  color: selected_category == index ? Colors.white : Color(0xff272525),
                                                  //     errorBuilder: (context, error, stackTrace) {
                                                  //       return Icon(Icons.fastfood,color: selected_category==index?Colors.white:Colors.black87,size: 0.07*MediaQuery.of(context).size.height,);
                                                  // },
                                                ),
                                              ) :
                                              Icon(Icons.fastfood,color: selected_category==index?Colors.white:Colors.black87,size: 0.1*MediaQuery.of(context).size.height,),
                                              decoration: BoxDecoration(
                                                  boxShadow: [
                                                    MediaQuery.of(context).size.width<768?
                                                    selected_category==index||categories[index].image!=null?
                                                    BoxShadow(
                                                      color: Colors.white.withOpacity(0.0),
                                                      offset: Offset(0, MediaQuery.of(context).size.height * 0.07/5), //(x,y)
                                                      blurRadius: 5.0,
                                                      spreadRadius: -15,
                                                    )
                                                        :BoxShadow(
                                                      color: Colors.grey.withOpacity(1),
                                                      offset: Offset(0, MediaQuery.of(context).size.height * 0.07/5), //(x,y)
                                                      blurRadius: 5.0,
                                                      spreadRadius: -15,):
                                                    BoxShadow(
                                                      color: Colors.red.withOpacity(0.0),
                                                      offset: Offset(0, MediaQuery.of(context).size.height * 0.07/5), //(x,y)
                                                      blurRadius: 5.0,
                                                      spreadRadius: -15,
                                                    ),
                                                  ],
                                              ),
                                            ),
                                            Text(
                                              categories[index].name!,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.bold,
                                                  color: selected_category == index ? Colors.white : Color(0xff272525)
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ),
                        ],
                      ),
                    ):_loadingCategory(),
                  ],
                ),
                Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.15,
                        decoration: BoxDecoration(
                            color: Color(0xff272525),
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25))
                        ),
                      ),
                    ),
                    /**search bar*/
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.14,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: GestureDetector(
                                onTap: () {
                                  _scaffoldkey.currentState!.openDrawer();
                                },
                                child: Image.asset(
                                  "assets/menu1.png",
                                ),
                              ),
                            ),
                            SizedBox(width: 40,),
                            AnimatedContainer(
                              duration: Duration(milliseconds: 500),
                              width: isPress ? MediaQuery.of(context).size.width * 0.6 : 0,
                              height: MediaQuery.of(context).size.height * 0.07,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/logo.png'),
                                ),
                              ),
                            ),
                            AnimatedContainer(
                              duration: Duration(milliseconds: 500),
                              width: !isPress ? MediaQuery.of(context).size.width * 0.6 : 0,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: !isPress ?
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10),
                                child: TextField(onSubmitted: (q){
                                  if(q.isNotEmpty){
                                    get_search(q);
                                  }else{
                                    print('empty');
                                  }
                                },
                                  cursorColor: Colors.white,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xff272525).withOpacity(0.8),
                                    fontSize: 20,
                                  ),
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.search, size: 18),
                                    prefixIconConstraints: BoxConstraints(
                                      minHeight: 0,
                                      minWidth: 0,
                                    ),
                                    hintText: App_Localization.of(context)!.translate("find_your_favorite_dish"),
                                    hintStyle: TextStyle(
                                      color: Color(0xff272525).withOpacity(0.6),
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ) : Text(''),
                            ),
                            SizedBox(width: 40,),
                            /*
                                                       Container(
                            width: MediaQuery.of(context).size.width>=400?MediaQuery.of(context).size.width * 0.7:MediaQuery.of(context).size.width * 0.5,
                            height: 30,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10),
                              child: TextField(
                                onSubmitted: (q){
                                  if(q.isNotEmpty){
                                    get_search(q);
                                  }else{
                                    print('empty');
                                  }
                                },
                                cursorColor: Colors.white,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xff272525).withOpacity(0.8),
                                  fontSize: 20,
                                ),
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.search, size: 18),
                                  prefixIconConstraints: BoxConstraints(
                                    minHeight: 0,
                                    minWidth: 0,
                                  ),
                                  hintText: App_Localization.of(context)!.translate("find_your_favorite_dish"),
                                  hintStyle: TextStyle(
                                    color: Color(0xff272525).withOpacity(0.6),
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),

                           */
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isPress = !isPress;
                                  });
                                  // Global.get_cart(context).then((value) {
                                  //   _calc_total();
                                  // });
                                },
                                child: isPress ?
                                Container(

                                    child: Icon(Icons.search, color: Colors.white,size: 25,)) :
                                Container(
                                    child: Icon(Icons.close, color: Colors.white,size: 25,))
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ],
            )),
            AnimatedSwitcher(
              duration: Duration(milliseconds: 1000),
              child: show ? GestureDetector(
                onTap: (){
                  Global.get_cart(context).then((value) {
                    _calc_total();
                  });
                },
                child: Padding(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.08),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.08,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: Offset(0, 2), // changes position of shadow
                              ),
                            ],
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.05,
                              width: MediaQuery.of(context).size.height * 0.05,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.red,
                              ),
                              child: Center(
                                  child: Text(
                                    Global.my_order.length.toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ),
                            Text(
                              App_Localization.of(context)!.translate("the_price"),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "|",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              App_Localization.of(context)!.translate("aed")+" "+Global.total.toString(),//total.toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ) : Text(''),
            ),
            AnimatedOpacity(
              opacity: MediaQuery.of(context).viewInsets.bottom == 0.0 ? 1 : 0,
              curve: Curves.easeIn,
              duration: Duration(milliseconds: 100),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.035,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      color: Color(0xff272525),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                        margin: EdgeInsets.only(bottom: 5),
                        width: MediaQuery.of(context).size.width*0.13,
                        height: MediaQuery.of(context).size.width*0.13,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: Offset(1, -2), // changes position of shadow
                            ),
                          ],
                          border: Border.all(width: 2, color: Colors.white),
                          shape: BoxShape.circle,
                          color: Color(0xff272525),
                        ),
                        child: Icon(Icons.home,color: Colors.white,)
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.003,
                    decoration: BoxDecoration(
                      color: Color(0xff272525),
                    ),
                  ),
                ],
              ) ,
            ),
          ],
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {

    // set up the button
    Widget okButton = TextButton(
      child: Text(App_Localization.of(context)!.translate("ok")),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape:  RoundedRectangleBorder(
          borderRadius:
          BorderRadius.all(Radius.circular(15.0))),
      title: Stack(
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(App_Localization.of(context)!.translate("note")),
            ],
          ),

        ],
      ),
      content: Container(
        height: 110,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(App_Localization.of(context)!.translate("cannot_poke_song"),style: TextStyle(fontSize: 17),),
              SizedBox(
                height: 20,
              ),
              CountdownTimer(
                endTime: DateTime.now().millisecondsSinceEpoch + 1000 * 3600,
                onEnd: (){

                },
                textStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 35,color: Colors.red),
              ),
            ],
          ),
        ),
      ),
      /*actions: [
        okButton,
      ],*/
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  get_category(){
    if(categories.isEmpty){
      Connecter.check_internet().then((internet) {
        print(internet);
        if(!internet){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NoInternet()),
          ).then((value) {
            get_category();
          });
        }else{
          if(categories.isEmpty){
            if(Global.categories.isEmpty){
              WordPressConnecter.get_category().then((WPcategories) {
                Global.categories.addAll(WPcategories);
                get_product();
              });
            }else{
              categories.clear();
              setState(() {
                categories.addAll(Global.categories);
                get_product();
              });
            }
          }
        }
      });
    }


  }
  get_product(){
    Connecter.check_internet().then((internet) {
      if(!internet){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NoInternet()),
        ).then((value) {
          get_product();
        });
      }else{
        if(this.categories.isEmpty){
          get_category();
        }else{
          setState(() {
            loading=true;
          });
          WordPressConnecter.get_products(categories[selected_category].id!).then((products) {
            this.products.clear();
            setState(() {
              this.products.addAll(products);
              loading=false;
            });
          });
        }
      }
    });

  }
  _loading(){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height*0.5,
      child: Center(child: CircularProgressIndicator()),
    );
  }
  _loadingCategory(){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height*0.15,
      child: Center(child: CircularProgressIndicator()),
    );
  }
  _calc_total(){
    setState(() {
      Global.total=Global.get_total();
    });
  }


}
