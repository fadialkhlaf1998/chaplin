import 'package:carousel_slider/carousel_slider.dart';
import 'package:chaplin_new_version/controler/connector.dart';
import 'package:chaplin_new_version/controler/setting.dart';
import 'package:chaplin_new_version/controler/story_api.dart';
import 'package:chaplin_new_version/controler/wordpress_connector.dart';
import 'package:chaplin_new_version/helper/app_localization.dart';
import 'package:chaplin_new_version/model/category.dart';
import 'package:chaplin_new_version/model/global.dart';
import 'package:chaplin_new_version/model/product.dart';
import 'package:chaplin_new_version/view/billing.dart';
import 'package:chaplin_new_version/view/favorite.dart';
import 'package:chaplin_new_version/view/item.dart';
import 'package:chaplin_new_version/view/music.dart';
import 'package:chaplin_new_version/view/my_point.dart';
import 'package:chaplin_new_version/view/no_internet.dart';
import 'package:chaplin_new_version/view/photo_picker.dart';
import 'package:chaplin_new_version/view/qr_scanner.dart';
import 'package:chaplin_new_version/view/shipping.dart';
import 'package:chaplin_new_version/view/sign_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';


class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int selder_selected = 0;
  int selected_category = 0;
  int count = 0;
  double total = 0;
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  final snackBar = SnackBar(content: Text('your product added to cart'));
  final must_login_snackBar = SnackBar(content: Text('you must login first'));
  bool music_poked=true;
  bool loading=false;
  List<ProductCategory> categories=<ProductCategory>[];
  List<Product> products=<Product>[];

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
        loading=false;
      }).catchError((){
        loading=false;
      });
    });
  }




  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    get_category();
    return Scaffold(
      key: _scaffoldkey,
      drawer: Drawer(
        child: SafeArea(
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/sidebar_cover.png"),
                      fit: BoxFit.cover
                  )
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
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
                          child: Padding(padding: EdgeInsets.only(top: 15,left: 15,right: 15),
                            child: Global.customer==null?Center():Text(App_Localization.of(context)!.translate("logout"),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                          ),
                        ),
                      ],
                    ),
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
                                  // print(Global.customer!.id!);
                                StoryApi.get_stories(Global.customer_id).then((value) {
                                  StoryApi.get_my_story(Global.customer_id).then((my_story){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => PhotoPicker(value,my_story)),
                                    );
                                  });

                                  });
                                });

                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(builder: (context) => Profile()),
                                // );
                              }

                            },
                            child: Padding(padding: EdgeInsets.only(left: 15,right: 15),
                              child: Text(App_Localization.of(context)!.translate("profile"),style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
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
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 20),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //
                    //       GestureDetector(
                    //         onTap: (){
                    //           Navigator.push(
                    //             context,
                    //             MaterialPageRoute(builder: (context) => const MyPoints()),
                    //           );
                    //         },
                    //         child: Padding(padding: EdgeInsets.only(left: 15,right: 15),
                    //           child: Text("MY POINTS",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    //         ),
                    //       ),
                    //
                    //     ],
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 20),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //
                    //       GestureDetector(
                    //         onTap: (){
                    //           if(Global.customer!=null){
                    //             Navigator.push(
                    //               context,
                    //               MaterialPageRoute(builder: (context) => Billing(0)),
                    //             );
                    //           }else{
                    //             Navigator.push(
                    //               context,
                    //               MaterialPageRoute(builder: (context) => Sign_In()),
                    //             );
                    //             // _scaffoldkey.currentState!.showSnackBar(must_login_snackBar);
                    //           }
                    //         },
                    //         child: Padding(padding: EdgeInsets.only(left: 15,right: 15),
                    //           child: Text("MY BILL",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    //         ),
                    //       ),
                    //
                    //     ],
                    //   ),
                    // ),
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
                              child: Text(App_Localization.of(context)!.translate("favorite"),style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
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
                              child: Text(App_Localization.of(context)!.translate("my_address"),style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 20,left: 20,right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(onPressed: (){
                            //todo nav to instgram
                          }, icon: const ImageIcon(
                            AssetImage("assets/social-media/insta.png"),
                            size: 40,
                          )),
                          IconButton(onPressed: (){
                            //todo nav to twitter
                          }, icon: const ImageIcon(
                            AssetImage("assets/social-media/twitter.png"),
                            size: 40,
                          )),
                          IconButton(onPressed: (){
                            //todo nav to facebook
                          }, icon: const ImageIcon(
                            AssetImage("assets/social-media/facebook.png"),
                            size: 40,
                          )),
                          IconButton(onPressed: (){
                            //todo nav to youtube
                          }, icon: const ImageIcon(
                            AssetImage("assets/social-media/youtube.png",),
                            size: 25,
                          )),

                        ],
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(width: MediaQuery.of(context).size.width*0.1,),
                          GestureDetector(
                            child: Text(App_Localization.of(context)!.translate("privace_policy"),style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                            onTap: (){
                              // Todo : nav
                            },
                          ),
                          Text("."),
                          GestureDetector(
                            child: Text(App_Localization.of(context)!.translate("term_of_sale"),style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                            onTap: (){
                              // Todo : nav
                            },
                          ),
                          Text("."),
                          GestureDetector(
                            child: Text(App_Localization.of(context)!.translate("term_of_use"),style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                            onTap: (){
                              // Todo : nav
                            },
                          ),
                          SizedBox(width: MediaQuery.of(context).size.width*0.1,),
                        ],
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(width: MediaQuery.of(context).size.width*0.1,),
                          GestureDetector(
                            child: Text(App_Localization.of(context)!.translate("return_policy"),style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                            onTap: (){
                              // Todo : nav
                            },
                          ),
                          Text("."),
                          GestureDetector(
                            child: Text(App_Localization.of(context)!.translate("warranty_policy"),style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                            onTap: (){
                              // Todo : nav
                            },
                          ),



                          SizedBox(width: MediaQuery.of(context).size.width*0.1,),
                        ],
                      ),
                    ),
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

      ),
      body: Stack(
        children: [
          SafeArea(
            child: Container(
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
                        /**search bar*/
                        Positioned(
                          top: 10,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    _scaffoldkey.currentState!.openDrawer();
                                  },
                                  icon: SvgPicture.asset(
                                      "assets/details.svg",
                                      color: Colors.white,
                                      semanticsLabel: 'details'
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width>=400?MediaQuery.of(context).size.width * 0.6:MediaQuery.of(context).size.width * 0.5,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(157, 153, 152, 0.52),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: TextField(
                                      onSubmitted: (q){
                                        get_search(q);
                                      },
                                      cursorColor: Colors.white,
                                      textAlignVertical: TextAlignVertical.bottom,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: App_Localization.of(context)!.translate("search"),
                                        hintStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    Global.get_cart(context).then((value) {
                                      _calc_total();
                                    });
                                  },

                                  /**/
                                  icon: Icon(
                                    Icons.shopping_cart_outlined,
                                    color: Colors.white,
                                    size: 23,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    if(Global.had_music){
                                      showAlertDialog(context);
                                    }else{
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => const QRScanner()),
                                      );
                                    }
                                  },
                                  icon: Icon(Icons.qr_code,
                                      color: Colors.white, size: 23),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    categories.isNotEmpty?Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.2<=160?160:MediaQuery.of(context).size.height * 0.2,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          image: DecorationImage(
                              image: AssetImage(
                                "assets/dashboard/background_list.png",
                              ),
                              fit: BoxFit.cover)),
                      child: Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.05<40?40:MediaQuery.of(context).size.height * 0.05,
                            child: Padding(
                              padding:
                                  EdgeInsets.only(left: 15, right: 15, top: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    App_Localization.of(context)!.translate("categories"),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    App_Localization.of(context)!.translate("offers"),
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 0, right: 0),
                            child: Container(
                              height:  MediaQuery.of(context).size.height * 0.15<99?99:MediaQuery.of(context).size.height * 0.15,
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
                                        });
                                        get_product();

                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            left: 5,
                                            right: 5,
                                            top: 15,
                                            bottom: 15),
                                        width:
                                            MediaQuery.of(context).size.height *
                                                0.15,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.15,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            // BoxShape.circle or BoxShape.retangle
                                            color: selected_category == index
                                                ? Colors.black87
                                                : Colors.white,

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

                                              width: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.1,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.07,
                                              child:categories[index].image!=null?ClipRRect(
                                                borderRadius: BorderRadius.circular(7),
                                                child: Image.network(
                                                  categories[index].image!,
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context, error, stackTrace) {
                                                    return Icon(Icons.fastfood,color: selected_category==index?Colors.white:Colors.black87,size: 0.07*MediaQuery.of(context).size.height,);
                                                  },
                                                ),
                                              ):Icon(Icons.fastfood,color: selected_category==index?Colors.white:Colors.black87,size: 0.1*MediaQuery.of(context).size.height,),
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

                                                ]
                                              ),
                                            ),
                                            Text(
                                              categories[index].name!,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      selected_category == index
                                                          ? Colors.white
                                                          : Colors.black87),
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
                    Container(
                      color: Colors.black87,
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
                              mainAxisExtent: MediaQuery.of(context).size.height>600? MediaQuery.of(context).size.height * 0.19+MediaQuery.of(context).size.width*0.075: MediaQuery.of(context).size.height * 0.3+MediaQuery.of(context).size.width*0.075//MediaQuery.of(context).size.height>600? MediaQuery.of(context).size.height * 0.18: MediaQuery.of(context).size.height * 0.21
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
                                          height:MediaQuery.of(context).size.height>600? MediaQuery.of(context).size.height * 0.19+MediaQuery.of(context).size.width*0.075: MediaQuery.of(context).size.height * 0.3+MediaQuery.of(context).size.width*0.075,//MediaQuery.of(context).size.height>600? MediaQuery.of(context).size.height * 0.18: MediaQuery.of(context).size.height * 0.21,
                                          color: Colors.transparent,
                                          child: Center(
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  0.9,
                                              height: MediaQuery.of(context).size.height>600? MediaQuery.of(context).size.height * 0.19: MediaQuery.of(context).size.height * 0.3,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                BorderRadius.circular(10),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceEvenly,
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child:  Padding(
                                                      padding: const EdgeInsets.only(left: 0,right: 15),
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
                                                    flex: 2,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
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
                                                          //height: 70,
                                                            child: Center(
                                                                child:  Html(
                                                                  data: this.products[index].description!,
                                                                  style: {
                                                                    "body" : Style(fontSize: FontSize(17), maxLines: 3)
                                                                  },
                                                                ),
                                                            )),
                                                        Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            Text(
                                                              App_Localization.of(context)!.translate("aed")+" "+this.products[index].price!,
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                  color: Colors
                                                                      .red),
                                                            ),
                                                             SizedBox(height: 10),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        bottom: 10,),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .end,
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            //_scaffoldkey.currentState!.showSnackBar(snackBar);
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
          ),
          Positioned(
              bottom: 0,
              right: MediaQuery.of(context).size.width * 0.05 - 8,
              child: GestureDetector(
                onTap: (){
                  Global.get_cart(context).then((value) {
                    _calc_total();
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.08,
                        decoration: BoxDecoration(
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
              )),
        ],
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
