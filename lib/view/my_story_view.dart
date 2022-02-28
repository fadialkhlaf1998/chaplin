
import 'package:chaplin_new_version/controler/story_api.dart';
import 'package:chaplin_new_version/model/global.dart';
import 'package:chaplin_new_version/model/story.dart';
import 'package:chaplin_new_version/view/dashboard.dart';
import 'package:chaplin_new_version/view/pick_your_choose.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:story_view/story_view.dart';
import 'package:chaplin_new_version/model/story_image.dart';

class MyStory_View extends StatefulWidget {
  List<StoryItem> storyItems;
  StoryController controller ;
  List<MyStoryImage> images;

  MyStory_View(this.storyItems,this.controller,this.images);

  @override
  _MyStoryViewState createState() => _MyStoryViewState(this.storyItems,this.controller,this.images);
}

class _MyStoryViewState extends State<MyStory_View> {
  final ImagePicker _picker = ImagePicker();
  List<StoryItem> storyItems;
  StoryController controller ;
  bool loading=false ;
  List<MyStoryImage> images;
  _MyStoryViewState(this.storyItems,this.controller,this.images);
  int index=0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: !loading && storyItems.isNotEmpty?StoryView(
              controller: controller, // pass controller here too
              repeat: true, // should the stories be slid forever
              inline: true,
              onStoryShow: (s) {
                //index++
                },
              onComplete: () {
                //Navigator.of(context).pop();
                index=0;
              },
              onVerticalSwipeComplete: (direction) {
                if (direction == Direction.down) {
                  Navigator.pop(context);
                }
              }, storyItems: storyItems, // To disable vertical swipe gestures, ignore this parameter.
              // Preferrably for inline story view.
            ):Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.black,
              child:Center(child: CircularProgressIndicator(color: Colors.white,),),
            ),
          ),
          Positioned(bottom: 10,child: Container(
            color: Colors.transparent,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        controller.pause();
                        showModalBottomSheet(
                          context: context,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(25),
                                )
                              ),
                          builder: (_){
                            return StatefulBuilder(
                            builder: (context, setState0) {
                              setState0((){
                                storyItems;
                                print('================');
                                print(images.length);
                                print(storyItems.length);
                              });
                              return DraggableScrollableSheet(
                                  initialChildSize: 0.5,
                                  expand: false,
                                  builder: (context, scrollController){
                                    return Container(
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(top: 20,bottom: 5),
                                            child: Text('Your stories', style: TextStyle(fontSize: 22)),
                                          ),
                                          Divider(thickness: 1,indent: 70,endIndent: 70,color: Color(0xff231F20)),
                                          SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Container(
                                              margin: EdgeInsets.only(left: 10, right: 10),
                                              height: MediaQuery.of(context).size.height * 0.2,
                                              child: ListView.builder(
                                                scrollDirection: Axis.horizontal,
                                                shrinkWrap: true,
                                                physics: NeverScrollableScrollPhysics(),
                                                controller: scrollController,
                                                itemCount: storyItems.length,
                                                itemBuilder: (context, index){
                                                  return Container(
                                                    padding: EdgeInsets.only(bottom: 10,right: 10),
                                                    child: Stack(
                                                      alignment: Alignment.center,
                                                      children: [
                                                        Container(
                                                          width: MediaQuery.of(context).size.width * 0.19,
                                                          height: MediaQuery.of(context).size.height * 0.15,
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(10),
                                                              image: DecorationImage(
                                                                  image: NetworkImage(StoryApi.media_url+images[index].link),
                                                                  fit: BoxFit.cover
                                                              )
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 35,
                                                          height: 35,
                                                          decoration: BoxDecoration(
                                                            color: Colors.white.withOpacity(0.7),
                                                            shape: BoxShape.circle
                                                          ),
                                                        ),
                                                        IconButton(
                                                          onPressed: ()  {
                                                            setState0((){
                                                              loading = true;
                                                              storyItems;
                                                              images;
                                                              loading = false;
                                                            });
                                                            // delete_image(index+1);
                                                            setState(() {
                                                              setState0((){
                                                                loading=true;
                                                                StoryApi.delete_image(images[index].id);
                                                                setState0(() {
                                                                  storyItems.removeAt(index);
                                                                  images.removeAt(index);
                                                                });
                                                                if(storyItems.isEmpty){
                                                                  StoryApi.get_stories(Global.customer_id).then((value) {
                                                                      Navigator.pushReplacement(context,  MaterialPageRoute(builder: (context) => PickChoose(value,null)));
                                                                    });
                                                                }
                                                                loading=false;
                                                              });
                                                            });
                                                          },
                                                          icon: Icon(Icons.delete, size: 25,color: Colors.black.withOpacity(0.8)),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                          //  SizedBox(height: 200)
                                        ],
                                      ),
                                    );
                                  }
                              );
                            });
                          }
                        );
                      },
                      icon: Icon(Icons.delete,color: Colors.white)),
                  IconButton(onPressed: (){
                    showAlertDialog(context);
                    }, icon: Icon(Icons.add,color: Colors.white,)),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }

  delete_image(int index){
    setState(() {
      loading=true;
      StoryApi.delete_image(images[index-1].id);
      setState(() {
        storyItems.removeAt(index-1);
        if(index!=0)
        index=index-1;
      });
      if(storyItems.isEmpty){
        Navigator.pop(context);
        StoryApi.get_stories(Global.customer_id).then((value) {
          StoryApi.get_my_story(Global.customer_id).then((my_story){
            Navigator.pushReplacement(context,  MaterialPageRoute(builder: (context) => PickChoose(value,my_story)));
          });
        });
      }
      loading=false;
    });
  }
  showAlertDialog(BuildContext context) {
    // Create button
    Widget okButton = FlatButton(
      child: Text("OK", style: TextStyle(fontSize: 22),),
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
              Navigator.of(context).pop();
              _picker.pickMultiImage().then((value) async{
              pick_image(value!);
             });
            },
            icon: Icon(Icons.photo,size: 50,),),
          IconButton(
              padding: EdgeInsets.all(0),
              onPressed: (){
            List<XFile> value=<XFile>[];
            _picker.pickVideo(source: ImageSource.gallery).then((file) {
              value.add(file!);
              pick_image(value);
            });
            Navigator.of(context).pop();
            },
              icon: Icon(Icons.video_call_outlined,size: 50)),
          IconButton(
              padding: EdgeInsets.all(0),
              onPressed: (){
            List<XFile> value=<XFile>[];
            _picker.pickImage(source: ImageSource.camera).then((file) {
              value.add(file!);
              pick_image(value);
            });
            Navigator.of(context).pop();
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
      setState(() {
        loading = true;
      });
      for(int i=0;i<value.length;i++){
        print(Global.customer_id!=-1);
        await StoryApi.add_story(Global.customer_id, value[i].path);
        print('****');
      }
      setState(() {
        StoryApi.get_my_story(Global.customer_id).then((value) {
          get_images_my_story(value!);
        });
        loading=false;
      });

  }
  get_images_my_story(Story my_story){
    setState(() {
      loading=true;
    });
    List<StoryItem> storyItems0=<StoryItem>[];
    List<MyStoryImage> images0 = <MyStoryImage>[];
    final controller = StoryController();
    StoryApi.get_images(my_story.id).then((value) {
      images.clear();
      for(int i=0;i<value.length;i++){
        images0.add(value[i]);
        if(value[i].link.endsWith("mp4")){
          print('******************************');
          print(StoryApi.media_url+value[i].link);
          storyItems0.add(StoryItem.pageVideo(StoryApi.media_url+value[i].link,controller: controller));
        }else{
          storyItems0.add(StoryItem.pageImage(url: StoryApi.media_url+value[i].link,controller: controller));
        }
      }
      setState(() {
        storyItems=storyItems0;
        images = images0;
        loading=false;
      });
    });
  }



}
