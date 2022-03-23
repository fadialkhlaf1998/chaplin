import 'package:chaplin_new_version/controler/setting.dart';
import 'package:chaplin_new_version/controler/story_api.dart';
import 'package:chaplin_new_version/controler/wordpress_connector.dart';
import 'package:chaplin_new_version/helper/app_localization.dart';
import 'package:chaplin_new_version/helper/my_app.dart';
import 'package:chaplin_new_version/model/global.dart';
import 'package:chaplin_new_version/model/product.dart';
import 'package:chaplin_new_version/model/story.dart';
import 'package:chaplin_new_version/view/billing.dart';
import 'package:chaplin_new_version/view/dashboard.dart';
import 'package:chaplin_new_version/view/favorite.dart';
import 'package:chaplin_new_version/view/my_story_view.dart';
import 'package:chaplin_new_version/view/qr_scanner.dart';
import 'package:chaplin_new_version/view/shipping.dart';
import 'package:chaplin_new_version/view/story_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_version/new_version.dart';
import 'package:story_view/story_view.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controler/store.dart';

class PickChoose extends StatefulWidget {

  List<Story> stories;
  Story? my_story;

  PickChoose(this.stories,this.my_story){
    Global.stories=this.stories;
  }

  @override
  _PickChooseState createState() => _PickChooseState(this.stories,this.my_story);
}

class _PickChooseState extends State<PickChoose> {

  var loading = false;
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  List<Product> products=<Product>[];
  int selected_category = 0;

  final ImagePicker _picker = ImagePicker();
  List<Story> stories;
  Story? my_story;
  bool pick=false;

  _PickChooseState(this.stories,this.my_story);

  _checkVersion(BuildContext context)async{
    //todo change IDS
    final newVersion = NewVersion(
      iOSId: "",
      androidId: 'com.snapchat.android',
    );
    final state = await newVersion.getVersionStatus();
    newVersion.showUpdateDialog(context: context, versionStatus: state!);
  }

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
  _calc_total(){
    setState(() {
      Global.total=Global.get_total();
    });
  }
 @override
  void initState() {
    super.initState();
    _checkVersion(context);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          if( await canLaunch("https://instagram.com/chaplin_uae?utm_medium=copy_link")){
                            await launch("https://instagram.com/chaplin_uae?utm_medium=copy_link");
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
                  Padding(padding: EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(width: MediaQuery.of(context).size.width*0.1,),
                        GestureDetector(
                          child: Text(App_Localization.of(context)!.translate("privace_policy"),style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                          onTap: (){
                            // Todo : nav
                          },
                        ),
                        Text("."),
                        GestureDetector(
                          child: Text(App_Localization.of(context)!.translate("term_of_sale"),style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                          onTap: (){
                            // Todo : nav
                          },
                        ),
                        Text("."),
                        GestureDetector(
                          child: Text(App_Localization.of(context)!.translate("term_of_use"),style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
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
                          child: Text(App_Localization.of(context)!.translate("return_policy"),style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                          onTap: (){
                            // Todo : nav
                          },
                        ),
                        Text("."),
                        GestureDetector(
                          child: Text(App_Localization.of(context)!.translate("warranty_policy"),style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
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
      key: _scaffoldkey,
      backgroundColor: Color(0xff231F20),
      body: SafeArea(
        child: Stack(
          children: [
            GestureDetector(
              onTap: (){
                setState(() {
                  pick=false;
                });
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context,  MaterialPageRoute(builder: (context) => const DashBoard()),);
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.17,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage("assets/pick_page/m.png"),
                                      fit: BoxFit.cover
                                  )
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  SvgPicture.asset("assets/pick_page/menu.svg",width: 60,),
                                  Container(
                                    width: MediaQuery.of(context).size.width*0.95-120,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Menu",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                                        SizedBox(height: 10,),
                                        Text("Great food within minutes",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 14),),
                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                Global.option = 0;
                              });
                              Store.load_music_timer().then((value) {
                                print(value);
                                if(value == false){
                                  App.err_msg(context, 'You can play song again after ${Store.dur} minutes');
                                }else{
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const QRScanner()),
                                  );
                                }
                              });
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.17,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage("assets/pick_page/2.png"),
                                      fit: BoxFit.cover
                                  )
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  SvgPicture.asset("assets/pick_page/music.svg",width: 60,),
                                  Container(
                                    width: MediaQuery.of(context).size.width*0.95-120,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Music",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                                        SizedBox(height: 10,),
                                        Text("Life is a song, let's enjoy together some good music",style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),),
                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              if(my_story == null){
                                if(Global.customer_id==-1){
                                  App.err_msg(context, App_Localization.of(context)!.translate("login_first"));
                                }else{
                                  setState(() {
                                    pick= !pick;
                                  });
                                }
                              }else{
                                get_images_my_story();
                              }
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.17,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage("assets/pick_page/3.png"),
                                      fit: BoxFit.cover
                                  )
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  SvgPicture.asset("assets/pick_page/story.svg",width: 60,),
                                  Container(
                                    width: MediaQuery.of(context).size.width*0.95-120,

                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Chaplin friends ",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                                        SizedBox(height: 10,),
                                        Text("Capture and share your special moments with us! ",style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),),
                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              //Navigator.push(context,  MaterialPageRoute(builder: (context) => const DashBoard()),);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const QRScanner()),
                              );
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.17,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage("assets/pick_page/4.png"),
                                      fit: BoxFit.cover
                                  )
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  SvgPicture.asset("assets/pick_page/car.svg",width: 60,),
                                  Container(
                                    width: MediaQuery.of(context).size.width*0.95-120,

                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Valet",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                                        SizedBox(height: 10,),
                                        Text("Ready to go? Request your car now",style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),),
                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 20),
                            child: Text('DEVELOPED BY MAXART',style: TextStyle(color: Colors.white), textAlign: TextAlign.center,),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Stack(
                            alignment: Alignment.bottomLeft,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height*0.22,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25),bottomRight: Radius.circular(25))
                                ),
                                child:  Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(left: 24, top: 10),
                                          child: GestureDetector(
                                            onTap: () {
                                              _scaffoldkey.currentState!.openDrawer();
                                            },
                                            child: Image.asset(
                                              "assets/menu2.png",
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context).size.width * 0.5,
                                          height: MediaQuery.of(context).size.height * 0.075,
                                          //  padding: EdgeInsets.only(top: 5,bottom: 5),
                                            child: SvgPicture.asset("assets/pick_page/logo.svg",height: 40,)
                                        ),
                                        /*
                                                                            Container(
                                          width: MediaQuery.of(context).size.width>=400?MediaQuery.of(context).size.width * 0.7:MediaQuery.of(context).size.width * 0.5,
                                          height: 30,
                                          decoration: BoxDecoration(
                                              color: Color(0xff272525),
                                              borderRadius: BorderRadius.circular(10)),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: TextField(
                                              onSubmitted: (q){
                                                if(q.isNotEmpty){
                                                  get_search(q);
                                                }
                                              },
                                              cursorColor: Colors.white,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                              ),
                                              decoration: InputDecoration(
                                                prefixIcon: Icon(Icons.search, size: 18, color: Colors.white.withOpacity(0.5),),
                                                prefixIconConstraints: BoxConstraints(
                                                  minHeight: 0,
                                                  minWidth: 0,
                                                ),
                                                hintText: App_Localization.of(context)!.translate("find_your_favorite_dish"),
                                                hintStyle: TextStyle(
                                                  color: Colors.white.withOpacity(0.5),
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),

                                         */
                                        IconButton(
                                          onPressed: () {
                                            // Global.get_cart(context).then((value) {
                                            //   _calc_total();
                                            // });
                                          },
                                          /**/
                                          icon: Icon(
                                            Icons.shopping_cart,
                                            color: Colors.white,
                                            size: 25,
                                          ),
                                        ),
                                      ],
                                    ),
                                    /** Add Story */
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 0),
                                      child: Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: MediaQuery.of(context).size.height*0.08,
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 10,right: 20),
                                          child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: Global.stories.length+1,
                                              itemBuilder: (context,index){
                                                return index==0 ?
                                                my_story==null ?
                                                /** Add story */
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 0,right: 0),
                                                  child:
                                                  /** my add button*/
                                                  GestureDetector(
                                                    onTap: (){

                                                      if(Global.customer_id==-1){
                                                        App.err_msg(context, App_Localization.of(context)!.translate("login_first"));
                                                      }else{
                                                        setState(() {
                                                          pick=true;
                                                        });
                                                      }
                                                    },
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        AnimatedContainer(
                                                          duration: Duration(milliseconds: 700),
                                                          curve: Curves.fastOutSlowIn,
                                                          width: !pick ? MediaQuery.of(context).size.height*0.08 : MediaQuery.of(context).size.width * 0.9,
                                                          height: MediaQuery.of(context).size.height*0.08,
                                                          // MediaQuery.of(context).size.width * 0.15
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height*0.04),
                                                            color: !pick ? Color(0xff231F20) : Colors.white,
                                                            border: Border.all(color: Colors.white,width: 2),
                                                          ),
                                                          child: AnimatedSwitcher(
                                                            duration: Duration(milliseconds: 500),
                                                                child: !pick
                                                                    ? Icon(Icons.add, color: Colors.white,size: 30,)
                                                                    :  SingleChildScrollView(
                                                                  scrollDirection: Axis.horizontal,
                                                                  child: Container(
                                                                    child: Row(
                                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                                      children: [
                                                                        GestureDetector(
                                                                          onTap: (){
                                                                            setState(() {
                                                                              pick=false;
                                                                            });
                                                                          },
                                                                          child: Container(
                                                                            width: 50,
                                                                            height: 50,
                                                                            decoration: BoxDecoration(
                                                                              shape: BoxShape.circle,
                                                                              color: Color(0xff231F20),
                                                                            ),
                                                                            child: Icon(Icons.close,color: Colors.white,)
                                                                          ),
                                                                        ),
                                                                        SizedBox(width: 10),
                                                                        GestureDetector(
                                                                          onTap: (){
                                                                            _picker.pickMultiImage().then((value) async{
                                                                              pick_image(value!);
                                                                            });
                                                                            pick = false;
                                                                          },
                                                                          child: Container(
                                                                            width: MediaQuery.of(context).size.width * 0.22,
                                                                            height: MediaQuery.of(context).size.height * 0.06,
                                                                            decoration: BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(20),
                                                                              color: Color(0xff231F20),
                                                                            ),
                                                                            child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              children: [
                                                                                Text('Images', style: TextStyle(color: Colors.white,fontSize: 15),),
                                                                               Icon(Icons.photo,size: 25,color: Colors.white,),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        SizedBox(width: 10),
                                                                        GestureDetector(
                                                                          onTap: (){
                                                                            List<XFile> value=<XFile>[];
                                                                            _picker.pickVideo(source: ImageSource.gallery).then((file) {
                                                                              value.add(file!);
                                                                              pick_image(value);
                                                                            });
                                                                            pick = false;
                                                                          },
                                                                          child: Container(
                                                                            height: MediaQuery.of(context).size.height * 0.06,
                                                                            width: MediaQuery.of(context).size.width * 0.22,
                                                                            decoration: BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(20),
                                                                              color: Color(0xff231F20),
                                                                            ),
                                                                            child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              children: [
                                                                                Text('Videos', style: TextStyle(color: Colors.white,fontSize: 15),),
                                                                               Icon(Icons.video_call_outlined,size: 31,color: Colors.white,),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        SizedBox(width: 10),
                                                                        GestureDetector(
                                                                          onTap: (){
                                                                            List<XFile> value=<XFile>[];
                                                                            _picker.pickImage(source: ImageSource.camera).then((file) {
                                                                              value.add(file!);
                                                                              pick_image(value);
                                                                            });
                                                                            pick = false;
                                                                          },
                                                                          child: Container(
                                                                            height: MediaQuery.of(context).size.height * 0.06,
                                                                            width: MediaQuery.of(context).size.width * 0.22,
                                                                            decoration: BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(20),
                                                                              color: Color(0xff231F20),
                                                                            ),
                                                                            child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              children: [
                                                                                Text('Camera', style: TextStyle(color: Colors.white,fontSize: 15),),
                                                                               Icon(Icons.camera_alt,size: 24,color: Colors.white,),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                )
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                                /** View my story */
                                                    : Padding(
                                                  padding: const EdgeInsets.only(left: 5,right: 5),
                                                  child: GestureDetector(
                                                    onTap: (){
                                                      //get_images(my_story.id,index-1);
                                                      get_images_my_story();
                                                    },
                                                    child: Container(
                                                      width: MediaQuery.of(context).size.height*0.08,
                                                      height: MediaQuery.of(context).size.height*0.08,
                                                      decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          border: Border.all(color: Colors.white,width: 3),
                                                          image: my_story!.image.endsWith("mp4")?DecorationImage(
                                                              image:AssetImage("assets/chapo.png"),
                                                              fit: BoxFit.cover
                                                          ):DecorationImage(
                                                              image:NetworkImage(StoryApi.media_url+my_story!.image),
                                                              fit: BoxFit.cover
                                                          )
                                                      ),
                                                    ),
                                                  ),
                                                )
                                                /** View people stories */
                                                    : Padding(
                                                      padding: const EdgeInsets.only(left: 0,right: 0),
                                                      child: GestureDetector(
                                                        onTap: (){
                                                        get_images(Global.stories[index-1].id,index-1);
                                                        },
                                                        child: Container(
                                                        width: MediaQuery.of(context).size.height*0.08+9,
                                                        height: MediaQuery.of(context).size.height*0.08+9,
                                                        decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        gradient:Global.stories[index-1].readed==0? LinearGradient(
                                                          colors: [
                                                            Colors.orange,
                                                            Colors.pinkAccent,
                                                          ],
                                                        ): LinearGradient(
                                                          colors: [
                                                            Colors.transparent,
                                                            Colors.transparent,
                                                          ],
                                                        ),
                                                        // borderRadius: BorderRadius.circular(35),
                                                      ),
                                                          child: Padding(
                                                        padding: const EdgeInsets.all(2),
                                                        child: Container(
                                                          width: MediaQuery.of(context).size.height*0.08+3,
                                                          height: MediaQuery.of(context).size.height*0.08+3,
                                                          decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            shape: BoxShape.circle,
                                                          ),
                                                          child: Padding(
                                                            padding: const EdgeInsets.all(1),
                                                            child: Container(
                                                              width: MediaQuery.of(context).size.height*0.08,
                                                              height: MediaQuery.of(context).size.height*0.08,
                                                              decoration: BoxDecoration(
                                                                  shape: BoxShape.circle,
                                                                  image: Global.stories[index-1].image.endsWith("mp4")?DecorationImage(
                                                                      image:AssetImage("assets/chapo.png"),
                                                                      fit: BoxFit.cover
                                                                  ):DecorationImage(
                                                                      image:NetworkImage(StoryApi.media_url+Global.stories[index-1].image),
                                                                      fit: BoxFit.cover
                                                                  )
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(child: loading?Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.grey.withOpacity(0.5),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ):Center()),
          ],
        ),
      ),
    );
  }

  pick_image(List<XFile> value)async{
    setState(() {
      loading = true;
    });

    for(int i=0;i<value.length;i++){
      await StoryApi.add_story(Global.customer_id, value[i].path);
    }
    StoryApi.get_my_story(Global.customer_id).then((value) {
      setState(() {
        my_story=value;
      });
      print(my_story!.image);
    });
    setState(() {
      loading=false;
    });
  }

  get_images(int id,int index){
    setState(() {
      loading=true;
    });
    List<StoryItem> storyItems=<StoryItem>[];
    final controller = StoryController();
    StoryApi.get_images(id).then((value) {
      for(int i=0;i<value.length;i++){
        if(value[i].link.endsWith("mp4")){
          print('***************people story***************');
          print(StoryApi.media_url+value[i].link);
          storyItems.add(StoryItem.pageVideo(StoryApi.media_url+value[i].link,controller: controller));
        }else{
          storyItems.add(StoryItem.pageImage(url: StoryApi.media_url+value[i].link,controller: controller));
        }
      }
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Story_View(storyItems,controller,Global.stories,index)),
      ).then((value){
        setState(() {
          loading=false;
          Global.stories;
        });
      });
    });
  }
  get_images_my_story(){
    setState(() {
      loading=true;
    });
    List<StoryItem> storyItems=<StoryItem>[];
    final controller = StoryController();
    StoryApi.get_images(my_story!.id).then((value) {
      for(int i=0;i<value.length;i++){
        if(value[i].link.endsWith("mp4")){
          print('**************story view****************');
          print(StoryApi.media_url+value[i].link);
          storyItems.add(StoryItem.pageVideo(StoryApi.media_url+value[i].link,controller: controller));
        }else{
          storyItems.add(StoryItem.pageImage(url: StoryApi.media_url+value[i].link,controller: controller));
        }
      }
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyStory_View(storyItems,controller,value)),
      ).then((value){
        StoryApi.get_my_story(Global.customer_id).then((value) {
          setState(() {
            loading=false;
            my_story=value;
          });
        });

      });
    });
  }

}

