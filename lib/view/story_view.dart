import 'package:chaplin_new_version/controler/story_api.dart';
import 'package:chaplin_new_version/model/global.dart';
import 'package:chaplin_new_version/model/story.dart';
import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';

class Story_View extends StatefulWidget {
  List<StoryItem> storyItems;
  StoryController controller ;
  List<Story> stories;
  int index;


  Story_View(this.storyItems,this.controller,this.stories,this.index);

  @override
  _StoryViewState createState() => _StoryViewState(this.storyItems,this.controller,this.stories,this.index);
}

class _StoryViewState extends State<Story_View> {

  List<StoryItem> storyItems;
  StoryController controller ;
  List<Story> stories;
  bool loading=false ;
  int index;
  _StoryViewState(this.storyItems,this.controller,this.stories,this.index);
  int index_item = 0;


  get_images(int id){
    setState(() {
      loading=true;
    });
    // final controller = StoryController();
    // controller  = StoryController();
    StoryApi.get_images(id).then((value) {
       storyItems.clear();
      List<StoryItem> storyItems0=<StoryItem>[];
      setState(() {
        for(int i=0;i<value.length;i++){
          if(value[i].link.endsWith("mp4")){
            storyItems0.add(StoryItem.pageVideo(StoryApi.media_url+value[i].link,controller: controller));
          }else{
            storyItems0.add(StoryItem.pageImage(url: StoryApi.media_url+value[i].link,controller: controller));
          }
        }
        storyItems=storyItems0;
        // Future.delayed(Duration(milliseconds: 3000)).then((value) {
          loading=false;
          index++;
        // });

        // controller  = StoryController();
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (context) => Story_View(storyItems,controller,this.stories,index)),
        // );
        // controller.play();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: !loading?
            StoryView(
              controller: controller, // pass controller here too
              repeat: true, // should the stories be slid forever
              inline: true,
              onStoryShow: (s) {
                index_item += 1;
                if(storyItems.length-1==index_item||storyItems.length==1){
                  StoryApi.read_story(stories[index].id, Global.customer_id);
                  Global.stories[index].readed = 1;
                }
                // controller.next();
              },
              onComplete: () {
                try{
                  print('-------------------');
                  print('story index:');
                  print(stories[index].id);
                  print('customers ID:');
                  print(Global.customer_id);
                  //StoryApi.read_story(stories[index].id, Global.customer_id);
                }catch(e){

                }
                //change_story_index(stories[index].id);
                if(index < stories.length-1){
                  get_images(stories[index+1].id);
                }else{
                  Navigator.pop(context);
                }

              },
              onVerticalSwipeComplete: (direction) {
                if (direction == Direction.down) {
                  Navigator.pop(context);
                }

              },
              storyItems: storyItems, // To disable vertical swipe gestures, ignore this parameter.
              // Preferrably for inline story view.
            ):Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.black,
              child:Center(child: CircularProgressIndicator(color: Colors.white,),),
            ),
          ),
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

  change_story_index(int story_id){
    for(int i=0;i<Global.stories.length;i++){
      if(story_id == Global.stories[i].id){
        Story temp = Global.stories[i];
        Global.stories.removeAt(i);
        temp.readed=1;
        Global.stories.add(temp);
      }
    }
  }

}
