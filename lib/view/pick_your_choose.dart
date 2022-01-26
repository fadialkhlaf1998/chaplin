import 'package:chaplin_new_version/controler/story_api.dart';
import 'package:chaplin_new_version/helper/app_localization.dart';
import 'package:chaplin_new_version/helper/my_app.dart';
import 'package:chaplin_new_version/model/global.dart';
import 'package:chaplin_new_version/model/story.dart';
import 'package:chaplin_new_version/view/dashboard.dart';
import 'package:chaplin_new_version/view/music.dart';
import 'package:chaplin_new_version/view/my_story_view.dart';
import 'package:chaplin_new_version/view/photo_picker.dart';
import 'package:chaplin_new_version/view/qr_scanner.dart';
import 'package:chaplin_new_version/view/story_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:story_view/story_view.dart';

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

  final ImagePicker _picker = ImagePicker();
  List<Story> stories;
  Story? my_story;
  bool pick=false;

  _PickChooseState(this.stories,this.my_story);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height*0.25,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25),bottomRight: Radius.circular(25))
                        ),
                        child:  Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 70,
                              child: SvgPicture.asset("assets/pick_page/logo.svg",height: 60,)
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 2),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height*0.09,
                                child: Padding(padding: EdgeInsets.only(left: 20,right: 20),
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: Global.stories.length+1,
                                      itemBuilder: (context,index){
                                        return index==0?
                                        my_story==null?Padding(
                                          padding: const EdgeInsets.only(left: 5,right: 5),
                                          child: GestureDetector(

                                            onTap: (){
                                               //showAlertDialog(context);
                                               //  setState(() {
                                               //    pick=true;
                                               //  });
                                              if(Global.customer_id==-1){
                                                App.err_msg(context, App_Localization.of(context)!.translate("login_first"));
                                              }else{
                                                //showAlertDialog(context);
                                                setState(() {
                                                  pick=true;
                                                });
                                              }

                                            },
                                            child: Container(
                                              width: MediaQuery.of(context).size.height*0.08,
                                              height: MediaQuery.of(context).size.height*0.08,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color(0xff231F20),
                                                border: Border.all(color: Colors.white,width: 2),
                                              ),
                                              child: Icon(Icons.add,size: 40,color: Colors.white,),
                                            ),
                                          ),
                                        ):Padding(
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
                                            : Padding(
                                          padding: const EdgeInsets.only(left: 5,right: 5),
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
                                                    padding: const EdgeInsets.all(3),
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
                      SizedBox(height: 10,),
                      Container(
                          height: 70,
                          child: Center(child: Text("We are in your service",style: TextStyle(fontSize: 22,color: Colors.white,fontWeight: FontWeight.bold),))
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context,  MaterialPageRoute(builder: (context) => const DashBoard()),);
                        },
                        child: Container(
                          height:120,
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MusicView()),
                          );
                          //Navigator.push(context,  MaterialPageRoute(builder: (context) => const DashBoard()),);
                        },
                        child: Container(
                          height:120,
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
                          //Navigator.push(context,  MaterialPageRoute(builder: (context) => const DashBoard()),);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PhotoPicker(stories, my_story)),
                          );
                        },
                        child: Container(
                          height:120,
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
                          height:120,
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
            Positioned(left: 20,top: MediaQuery.of(context).size.height*0.25-MediaQuery.of(context).size.height*0.08-20,child: Padding(
              padding: const EdgeInsets.only(left: 5,right: 5),
              child: GestureDetector(
                onTap: (){
                  setState(() {
                    pick=false;
                  });

                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 600),
                     curve: Curves.easeInOut,
                  width: MediaQuery.of(context).size.height*0.08,
                  height: pick?200:0,

                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height*0.04),

                      color: Color(0xff231F20),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.white,
                            blurRadius: 0.1,
                            spreadRadius: 0.1,
                            offset: Offset(0,1)
                        )
                      ]
                  ),
                  child:SingleChildScrollView(
                    child: Container(
                      height: 200,

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            padding: EdgeInsets.all(0),
                            onPressed: (){
                              _picker.pickMultiImage().then((value) async{
                                pick_image(value!);
                              });
                            }, icon: Icon(Icons.photo,size: 35,color: Colors.white,),),
                          IconButton(
                              padding: EdgeInsets.all(0),
                              onPressed: (){
                                List<XFile> value=<XFile>[];
                                _picker.pickVideo(source: ImageSource.gallery).then((file) {
                                  value.add(file!);
                                  pick_image(value);
                                });
                              }, icon: Icon(Icons.video_call_outlined,size: 38,color: Colors.white,)),
                          IconButton(
                              padding: EdgeInsets.all(0),
                              onPressed: (){
                                List<XFile> value=<XFile>[];
                                _picker.pickImage(source: ImageSource.camera).then((file) {
                                  value.add(file!);
                                  pick_image(value);
                                });
                              }, icon: Icon(Icons.camera_alt,size: 33,color: Colors.white,)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // Create button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Please pick"),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            padding: EdgeInsets.all(0),
            onPressed: (){
              _picker.pickMultiImage().then((value) async{
                pick_image(value!);
              });
            }, icon: Icon(Icons.photo,size: 50,),),
          IconButton(
              padding: EdgeInsets.all(0),
              onPressed: (){
                List<XFile> value=<XFile>[];
                _picker.pickVideo(source: ImageSource.gallery).then((file) {
                  value.add(file!);
                  pick_image(value);
                });
              }, icon: Icon(Icons.video_call_outlined,size: 50)),
          IconButton(
              padding: EdgeInsets.all(0),
              onPressed: (){
                List<XFile> value=<XFile>[];
                _picker.pickImage(source: ImageSource.camera).then((file) {
                  value.add(file!);
                  pick_image(value);
                });
              }, icon: Icon(Icons.camera_alt,size: 50)),
        ],
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  pick_image(List<XFile> value)async{

    Navigator.pop(context);
    setState(() {
      // images!.add(value!);
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

    // Navigator.pop(context);

    //Navigator.pop(context);


    // Navigator.pop(context);
  }

  // pick_image()async{
  //     _picker.pickMultiImage().then((value) async{
  //       setState(() {
  //         // images!.add(value!);
  //         loading = true;
  //
  //       });
  //       for(int i=0;i<value!.length;i++){
  //         print(Global.customer_id!=-1);
  //         await StoryApi.add_story(Global.customer_id, value[i].path);
  //         print('****');
  //       }
  //       setState(() {
  //         StoryApi.get_stories(Global.customer_id).then((value) {
  //           stories=value;
  //           Global.stories=value;
  //         });
  //         loading=false;
  //
  //       });
  //
  //
  //   });
  // }
  get_images(int id,int index){
    setState(() {
      loading=true;
    });
    List<StoryItem> storyItems=<StoryItem>[];
    final controller = StoryController();
    StoryApi.get_images(id).then((value) {
      for(int i=0;i<value.length;i++){
        if(value[i].link.endsWith("mp4")){
          print('******************************');
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
          print('******************************');
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
