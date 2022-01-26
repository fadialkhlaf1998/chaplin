import 'dart:io';

import 'package:chaplin_new_version/controler/story_api.dart';
import 'package:chaplin_new_version/model/global.dart';
import 'package:chaplin_new_version/model/story.dart';
import 'package:chaplin_new_version/view/my_story_view.dart';
import 'package:chaplin_new_version/view/story_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/story_view.dart';

class PhotoPicker extends StatefulWidget {
  List<Story> stories;
  Story? my_story;

  PhotoPicker(this.stories,this.my_story);

  @override
  _PhotoPickerState createState() => _PhotoPickerState(this.stories,this.my_story);
}

class _PhotoPickerState extends State<PhotoPicker> {
  final ImagePicker _picker = ImagePicker();
  List<XFile>? images=<XFile>[];
  List<Story> stories;
  bool loading = false;
  Story? my_story;

  _PhotoPickerState(this.stories,this.my_story){
    Global.stories=this.stories;
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.white,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height*0.2,
                          //color: Colors.black87,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/story.png",),
                              fit: BoxFit.cover
                            )
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(onPressed: (){
                                          Navigator.pop(context);
                                        }, icon: Icon(Icons.arrow_back_ios,color: Colors.white,)),
                                        Text("STORY",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
                                        IconButton(onPressed: (){
                                          // Navigator.pop(context);
                                        }, icon: Icon(Icons.arrow_back,color: Colors.transparent,))
                                      ],
                                    ),
                                  ),
                                  // Positioned(child: ,top: 10,)
                                ],
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
                                                showAlertDialog(context);
                                              },
                                              child: Container(
                                                width: MediaQuery.of(context).size.height*0.08,
                                                height: MediaQuery.of(context).size.height*0.08,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.white,
                                                  border: Border.all(color: Colors.white,width: 2),
                                                ),
                                                child: Icon(Icons.add,size: 40,),
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
                              )

                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Semantics(
                              child: GridView.builder(
                                shrinkWrap: true,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:  3,crossAxisSpacing: 10),
                                physics: NeverScrollableScrollPhysics(),
                                key: UniqueKey(),
                                itemBuilder: (context, index) {
                                  // Why network for web?
                                  // See https://pub.dev/packages/image_picker#getting-ready-for-the-web-platform
                                  return Semantics(
                                    label: 'image_picker_example_picked_image',
                                    child: Image.file(File(images![index].path)),
                                  );
                                },
                                itemCount: images!.length,
                              ),
                              label: 'image_picker_example_picked_images'),
                        ),

                      ],
                    ),
                  ),
                ),
            ),
            Positioned(child: loading==true?Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.white.withOpacity(0.4),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ):Center())
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
