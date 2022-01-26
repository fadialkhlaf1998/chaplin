import 'package:chaplin_new_version/controler/story_api.dart';
import 'package:chaplin_new_version/model/global.dart';
import 'package:chaplin_new_version/model/story.dart';
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
            child: !loading&&storyItems.isNotEmpty?StoryView(

              controller: controller, // pass controller here too
              repeat: true, // should the stories be slid forever
              inline: true,
              onStoryShow: (s) {
                // print('------------');
                // print(storyItems.length);
                // if(storyItems.length==1)
                // controller.next();
                index++;
                print(index);
                },
              onComplete: () {
                index=0;
              },
              onVerticalSwipeComplete: (direction) {
                if (direction == Direction.down) {
                  Navigator.pop(context);
                }
                // if (direction == Direction.right) {
                //   if(index<stories.length-1)
                //   get_images(stories[index+1].id);
                // }
                // if (direction == Direction.left) {
                //   if(index-1>0)
                //     get_images(stories[index-1].id);
                // }
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
                  IconButton(onPressed: (){delete_image(index);}, icon: Icon(Icons.delete,color: Colors.white)),
                  IconButton(onPressed: (){showAlertDialog(context);}, icon: Icon(Icons.add,color: Colors.white,)),
                ],
              ),
            ),
          ))
          // loading?Container(
          //   width: MediaQuery.of(context).size.width,
          //   height: MediaQuery.of(context).size.height,
          //   color: Colors.white.withOpacity(0.4),
          //   child:Center(child: CircularProgressIndicator(),),
          // ):Center(),
        ],
      ),
    );
  }

  delete_image(int index){
    setState(() {
      loading=true;

      StoryApi.delete_image(images[index-1].id);
      storyItems.removeAt(index-1);
      if(storyItems.isEmpty){
        Navigator.pop(context);
      }
      loading=false;
    });
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


      setState(() {
        // images!.add(value!);
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
      // Navigator.pop(context);

      // Navigator.pop(context);


    // Navigator.pop(context);
  }

  get_images_my_story(Story my_story){
    setState(() {
      loading=true;
    });
    List<StoryItem> storyItems0=<StoryItem>[];
    final controller = StoryController();
    StoryApi.get_images(my_story.id).then((value) {
      for(int i=0;i<value.length;i++){
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
        loading=false;
      });
    });
  }

}
