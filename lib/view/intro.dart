import 'package:chaplin_new_version/controler/connector.dart';
import 'package:chaplin_new_version/controler/setting.dart';
import 'package:chaplin_new_version/controler/story_api.dart';
import 'package:chaplin_new_version/controler/wordpress_connector.dart';
import 'package:chaplin_new_version/model/global.dart';
import 'package:chaplin_new_version/view/pick_your_choose.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


class Gif extends StatefulWidget {
  @override
  _GifState createState() => _GifState();
}

class _GifState extends State<Gif> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    AppSetting.is_verificated();
    AppSetting.get_timer();
    AppSetting.load();


    super.initState();
    // _controller = VideoPlayerController.asset("assets/intro.mp4")
    //   ..initialize().then((_) {
    //     // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
    //   });
    //
    //
    // _controller!.play();
    Connecter.get_number();
    WordPressConnecter.get_category().then((categories) {
      Global.categories.addAll(categories);
    });
    get_delay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Image.asset("assets/gif.gif",fit: BoxFit.cover,),
        )

      );

  }

  @override
  void dispose() {
    super.dispose();
    // _controller!.dispose();
  }
  get_delay(){
    Future.delayed(const Duration(milliseconds: 2500), () {
      if(mounted){
        if(Global.email!="non"){
          WordPressConnecter.get_customer(Global.email);
        }
        if(Global.is_signIn){
          print('*****************************');
          print(Global.customer_id);
          StoryApi.get_stories(Global.customer_id).then((value) {
            StoryApi.get_my_story(Global.customer_id).then((my_story){
              print("value.length");
              print(value.length);
              print("value.length");

              Navigator.pushReplacement(context,  MaterialPageRoute(builder: (context) => PickChoose(value,my_story)));
            });
          });
        }else if(Global.email!="non"){
          Navigator.pushNamedAndRemoveUntil(context, "code", (r) => false);
        }else{
          Navigator.pushNamedAndRemoveUntil(context, "signIn", (r) => false);
        }

      }


    });
  }
}
/*
class VideoApp extends StatefulWidget {
  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset("assets/intro.mp4")
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      });

    _controller!.play();
  }

  @override
  Widget build(BuildContext context) {
    get_delay();
    return MaterialApp(
      title: 'Video Demo',
      home: Scaffold(
        body: Center(
          child: _controller!.value.isInitialized
              ? AspectRatio(
            aspectRatio:MediaQuery.of(context).size.aspectRatio,
            child: VideoPlayer(_controller!),
          )
              : Container(),
        ),

      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller!.dispose();
  }
  get_delay(){
    Future.delayed(const Duration(milliseconds: 3500), () {
      if(mounted)
        Navigator.pushNamedAndRemoveUntil(context, "signIn", (r) => false);
    });
  }
}*/