import 'package:carousel_slider/carousel_slider.dart';
import 'package:chaplin_new_version/helper/app_localization.dart';
import 'package:chaplin_new_version/model/global.dart';
import 'package:chaplin_new_version/view/item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';


class Favorite extends StatefulWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  int selder_selected = 0;
  SnackBar snackBar = SnackBar(content: Text(""));
  SnackBar must_login_snackBar = SnackBar(content: Text(''));
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, (){
      snackBar = SnackBar(content: Text(App_Localization.of(context)!.translate("add_cart_msg")));
      must_login_snackBar = SnackBar(content: Text(App_Localization.of(context)!.translate("login_first")));
    });
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
      key: _scaffoldkey,
      // drawer: Drawer(
      //   child: SafeArea(
      //     child: Container(
      //       decoration: BoxDecoration(
      //           image: DecorationImage(
      //               image: AssetImage("assets/sidebar_cover.png"),
      //               fit: BoxFit.cover
      //           )
      //       ),
      //       child: SingleChildScrollView(
      //         child: Column(
      //           children: [
      //             Row(
      //               children: [
      //                 GestureDetector(
      //                   onTap: (){
      //                     AppSetting.set_verificated(false);
      //                     AppSetting.save("non", "non");
      //                     AppSetting.set_timer("non");
      //                     Global.customer=null;
      //                     Global.customer_id=-1;
      //                     Navigator.pushNamedAndRemoveUntil(context, "signIn", (r) => false);
      //                   },
      //                   child: Padding(padding: EdgeInsets.only(top: 15,left: 15,right: 15),
      //                     child: Global.customer==null?Center():Text("LOG OUT",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
      //                   ),
      //                 ),
      //               ],
      //             ),
      //             Row(
      //               mainAxisAlignment: MainAxisAlignment.center,
      //               children: [
      //                 Padding(
      //                   padding: const EdgeInsets.only(top: 40),
      //                   child: Container(
      //                     width: MediaQuery.of(context).size.width*0.3,
      //                     height: MediaQuery.of(context).size.width*0.3,
      //                     decoration: BoxDecoration(
      //                         color: Colors.transparent,
      //                         shape: BoxShape.circle
      //                     ),
      //                   ),
      //                 )
      //               ],
      //             ),
      //             Row(
      //               mainAxisAlignment: MainAxisAlignment.center,
      //               children: [
      //                 Padding(
      //                     padding: const EdgeInsets.only(top: 10),
      //                     child: Text("Charlie Chaplin",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
      //                 )
      //               ],
      //             ),
      //             Padding(
      //               padding: const EdgeInsets.only(top: 40),
      //               child: Row(
      //                 mainAxisAlignment: MainAxisAlignment.center,
      //                 children: [
      //                   Container(
      //                     height: 4,
      //                     width: 40,
      //                     color: Colors.black87,
      //                   ),
      //                   GestureDetector(
      //                     onTap: (){
      //                       Navigator.push(
      //                         context,
      //                         MaterialPageRoute(builder: (context) => const PhotoPicker()),
      //                       );
      //                     },
      //                     child: Padding(padding: EdgeInsets.only(left: 15,right: 15),
      //                       child: Text("PROFILE",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
      //                     ),
      //                   ),
      //                   Container(
      //                     height: 4,
      //                     width: 40,
      //                     color: Colors.black87,
      //                   ),
      //                 ],
      //               ),
      //             ),
      //             Padding(
      //               padding: const EdgeInsets.only(top: 20),
      //               child: Row(
      //                 mainAxisAlignment: MainAxisAlignment.center,
      //                 children: [
      //
      //                   GestureDetector(
      //                     onTap: (){
      //                       Navigator.push(
      //                         context,
      //                         MaterialPageRoute(builder: (context) => const MyPoints()),
      //                       );
      //                     },
      //                     child: Padding(padding: EdgeInsets.only(left: 15,right: 15),
      //                       child: Text("MY POINTS",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
      //                     ),
      //                   ),
      //
      //                 ],
      //               ),
      //             ),
      //             Padding(
      //               padding: const EdgeInsets.only(top: 20),
      //               child: Row(
      //                 mainAxisAlignment: MainAxisAlignment.center,
      //                 children: [
      //
      //                   GestureDetector(
      //                     onTap: (){
      //                       if(Global.is_signIn){
      //                         Navigator.push(
      //                           context,
      //                           MaterialPageRoute(builder: (context) => Billing(0)),
      //                         );
      //                       }else{
      //                         _scaffoldkey.currentState!.showSnackBar(must_login_snackBar);
      //                       }
      //                     },
      //                     child: Padding(padding: EdgeInsets.only(left: 15,right: 15),
      //                       child: Text("MY BILL",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
      //                     ),
      //                   ),
      //
      //                 ],
      //               ),
      //             ),
      //             Padding(
      //               padding: const EdgeInsets.only(top: 20),
      //               child: Row(
      //                 mainAxisAlignment: MainAxisAlignment.center,
      //                 children: [
      //                   GestureDetector(
      //                     onTap: (){
      //                       Navigator.push(
      //                         context,
      //                         MaterialPageRoute(builder: (context) => const Favorite()),
      //                       );
      //                     },
      //                     child: Padding(padding: EdgeInsets.only(left: 15,right: 15),
      //                       child: Text("FAVORITE",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //             Padding(
      //               padding: const EdgeInsets.only(top: 20),
      //               child: Row(
      //                 mainAxisAlignment: MainAxisAlignment.center,
      //                 children: [
      //                   GestureDetector(
      //                     onTap: (){
      //                       if(Global.is_signIn){
      //                         Navigator.push(
      //                           context,
      //                           MaterialPageRoute(builder: (context) => Shipping(0)),
      //                         );
      //                       }else{
      //                         _scaffoldkey.currentState!.showSnackBar(must_login_snackBar);
      //                       }
      //                     },
      //                     child: Padding(padding: EdgeInsets.only(left: 15,right: 15),
      //                       child: Text("MY ADDRESSE",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //             Padding(padding: EdgeInsets.only(top: 20,left: 20,right: 20),
      //               child: Row(
      //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //                 children: [
      //                   IconButton(onPressed: (){
      //                     //todo nav to instgram
      //                   }, icon: const ImageIcon(
      //                     AssetImage("assets/social-media/insta.png"),
      //                     size: 40,
      //                   )),
      //                   IconButton(onPressed: (){
      //                     //todo nav to twitter
      //                   }, icon: const ImageIcon(
      //                     AssetImage("assets/social-media/twitter.png"),
      //                     size: 40,
      //                   )),
      //                   IconButton(onPressed: (){
      //                     //todo nav to facebook
      //                   }, icon: const ImageIcon(
      //                     AssetImage("assets/social-media/facebook.png"),
      //                     size: 40,
      //                   )),
      //                   IconButton(onPressed: (){
      //                     //todo nav to youtube
      //                   }, icon: const ImageIcon(
      //                     AssetImage("assets/social-media/youtube.png",),
      //                     size: 25,
      //                   )),
      //
      //                 ],
      //               ),
      //             ),
      //             Padding(padding: EdgeInsets.only(top: 20),
      //               child: Row(
      //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //                 children: [
      //                   SizedBox(width: MediaQuery.of(context).size.width*0.1,),
      //                   GestureDetector(
      //                     child: Text("Privace Policy",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
      //                     onTap: (){
      //                       // Todo : nav
      //                     },
      //                   ),
      //                   Text("."),
      //                   GestureDetector(
      //                     child: Text("Terms Of Sale",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
      //                     onTap: (){
      //                       // Todo : nav
      //                     },
      //                   ),
      //                   Text("."),
      //                   GestureDetector(
      //                     child: Text("Terms Of Use",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
      //                     onTap: (){
      //                       // Todo : nav
      //                     },
      //                   ),
      //                   SizedBox(width: MediaQuery.of(context).size.width*0.1,),
      //                 ],
      //               ),
      //             ),
      //             Padding(padding: EdgeInsets.only(top: 10),
      //               child: Row(
      //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //                 children: [
      //                   SizedBox(width: MediaQuery.of(context).size.width*0.1,),
      //                   GestureDetector(
      //                     child: Text("Return Policy",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
      //                     onTap: (){
      //                       // Todo : nav
      //                     },
      //                   ),
      //                   Text("."),
      //                   GestureDetector(
      //                     child: Text("Warranty Policy",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
      //                     onTap: (){
      //                       // Todo : nav
      //                     },
      //                   ),
      //
      //
      //
      //                   SizedBox(width: MediaQuery.of(context).size.width*0.1,),
      //                 ],
      //               ),
      //             ),
      //             Padding(padding: EdgeInsets.only(top: 10),
      //               child: Row(
      //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //                 children: [
      //                   Text("Version 1.0",style: TextStyle(fontSize: 10,color: Colors.grey),),
      //                 ],
      //               ),
      //             ),
      //             Padding(padding: EdgeInsets.only(top: 10),
      //               child: Row(
      //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //                 children: [
      //                   Text("© 2018Chaplin. ALL RIGHTS RESERVED.",style: TextStyle(fontSize: 8,color: Colors.black,),),
      //                 ],
      //               ),
      //             ),
      //             Container(
      //               height: MediaQuery.of(context).size.height*0.1,
      //               width: MediaQuery.of(context).size.width*0.5,
      //               decoration: BoxDecoration(
      //                   image: DecorationImage(
      //                       image: AssetImage("assets/black_logo.png",),
      //                       fit: BoxFit.cover
      //                   )
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //   ),
      //
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.22,
                    color: Colors.grey,
                    child: Container(
                      color: Colors.black38,
                      height: MediaQuery.of(context).size.height * 0.26,
                      width: MediaQuery.of(context).size.width,
                      /**slider*/
                      child: CarouselSlider(
                        items: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/dashboard/slider_1.png"),
                                    fit: BoxFit.cover)),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height:
                            MediaQuery.of(context).size.height * 0.5,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/dashboard/slider_2.png"),
                                    fit: BoxFit.cover)),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height:
                            MediaQuery.of(context).size.height * 0.5,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/dashboard/slider_3.jpg"),
                                    fit: BoxFit.cover)),
                          ),
                        ],
                        options: CarouselOptions(
                          autoPlay: true,
                          enlargeCenterPage: true,
                          viewportFraction: 1,
                          aspectRatio: 2.0,
                          initialPage: 0,
                          onPageChanged: (index, reason) {
                            setState(() {
                              selder_selected = index;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  /**3 point*/
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.18,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                  color: selder_selected == 0
                                      ? Colors.white
                                      : Colors.transparent,
                                  shape: BoxShape.circle,
                                  border:
                                  Border.all(color: Colors.white)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                  color: selder_selected == 1
                                      ? Colors.white
                                      : Colors.transparent,
                                  shape: BoxShape.circle,
                                  border:
                                  Border.all(color: Colors.white)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                  color: selder_selected == 2
                                      ? Colors.white
                                      : Colors.transparent,
                                  shape: BoxShape.circle,
                                  border:
                                  Border.all(color: Colors.white)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: 15, top: 17),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back_ios, size: 25,color: Colors.white,),
                    ),
                  ),
                  /**search bar*/
                  // Positioned(
                  //   top: 10,
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //     children: [
                  //       IconButton(
                  //         onPressed: () {
                  //           // _scaffoldkey.currentState!.openDrawer();
                  //           Navigator.of(context).pop();
                  //         },
                  //         icon: Icon(
                  //           Icons.arrow_back_ios,
                  //           color: Colors.white,
                  //           size: 25,
                  //         ),
                  //       ),
                  //       Container(
                  //         width: MediaQuery.of(context).size.width * 0.65,
                  //         height: 30,
                  //         decoration: BoxDecoration(
                  //             color: Color.fromRGBO(157, 153, 152, 0.52),
                  //             borderRadius: BorderRadius.circular(10)),
                  //         child: Padding(
                  //           padding: const EdgeInsets.only(
                  //               left: 10, right: 10),
                  //           child: TextField(
                  //             cursorColor: Colors.white,
                  //             textAlignVertical: TextAlignVertical.bottom,
                  //             style: TextStyle(
                  //               color: Colors.white,
                  //               fontSize: 15,
                  //             ),
                  //             decoration: InputDecoration(
                  //               hintText: 'Search...',
                  //               hintStyle: TextStyle(
                  //                 color: Colors.white,
                  //                 fontSize: 13,
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //       IconButton(
                  //         onPressed: () {},
                  //         icon: Icon(
                  //           Icons.shopping_cart_outlined,
                  //           color: Colors.white,
                  //           size: 23,
                  //         ),
                  //       ),
                  //       IconButton(
                  //         onPressed: () {
                  //           Navigator.push(
                  //             context,
                  //             MaterialPageRoute(
                  //                 builder: (context) => const MusicView()),
                  //           );
                  //         },
                  //         icon: Icon(Icons.qr_code,
                  //             color: Colors.white, size: 23),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
              Padding(padding: EdgeInsets.only(left: 20,right: 20,top: 20),
                child: Row(
                  children: [
                    Text(App_Localization.of(context)!.translate("favorite"),style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)
                  ],
                ),
              ),
              Global.wishlist.isEmpty ? Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height *  0.4,
                child: Center(
                  child: Text(
                      App_Localization.of(context)!.translate("you_dont_have_any_favorite_food"),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ) :
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: Global.wishlist.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Item(Global.wishlist[index])));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 15,
                                right: 15,
                                top: 10,
                                bottom: 0),
                            child: Container(
                              height: MediaQuery.of(context)
                                  .size
                                  .height *
                                  0.18,
                              color: Colors.transparent,
                              child: Center(
                                child: Container(
                                  width: MediaQuery.of(context)
                                      .size
                                      .width *
                                      0.9,
                                  height: MediaQuery.of(context)
                                      .size
                                      .height *
                                      0.15,
                                  decoration: BoxDecoration(
                                    color: Colors.black87,
                                    borderRadius:
                                    BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceEvenly,
                                    children: [
                                      Container(
                                        width: MediaQuery.of(context).size.width*0.2,
                                        child: Image.network(
                                            Global.wishlist[index].images!.first.src!),
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width*0.5,
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .center,
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,
                                          children: [
                                            Text(
                                              Global.wishlist[index].name!,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight:
                                                  FontWeight
                                                      .bold,
                                              color: Colors.white),
                                            ),
                                            Html(
                                                data: Global.wishlist[index].description!,
                                              style: {
                                                  "body" : Style(
                                                      color: Colors.white,
                                                    maxLines: 2,
                                                      fontSize: FontSize(12),
                                                  ),
                                              },
                                            ),
                                            Text(
                                              App_Localization.of(context)!.translate("aed")+" "+Global.wishlist[index].price.toString(),
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight:
                                                  FontWeight
                                                      .bold,
                                                  color: Colors
                                                      .red),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(
                                            bottom: 10),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .end,
                                          children: [
                                            GestureDetector(
                                              onTap: () {},
                                              child: Container(
                                                height: 35,
                                                width: 35,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    shape: BoxShape.circle),
                                                child: Icon(
                                                  Icons.shopping_cart_outlined,
                                                  color: Colors.black87,
                                                  size: 20,
                                                ),
                                              ),
                                            )
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
                            right: 4,
                            top: -6,
                            child: Container(
                              width: 60,
                              height: 60,
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
            ],
          ),
        ),
      ),
    );
  }
}
