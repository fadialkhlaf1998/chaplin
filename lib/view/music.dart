import 'package:chaplin_new_version/controler/connector.dart';
import 'package:chaplin_new_version/controler/wordpress_connector.dart';
import 'package:chaplin_new_version/helper/my_app.dart';
import 'package:chaplin_new_version/model/global.dart';
import 'package:chaplin_new_version/model/music.dart';
import 'package:chaplin_new_version/model/music_json.dart';
import 'package:chaplin_new_version/view/no_internet.dart';
import 'package:chaplin_new_version/view/pick_your_choose.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../controler/store.dart';

class MusicView extends StatefulWidget {
  const MusicView({Key? key}) : super(key: key);

  @override
  _MusicState createState() => _MusicState();
}

class _MusicState extends State<MusicView> {
  
  int selected_music=0;
  List<MusicJson> music=<MusicJson>[];
  bool loading=false;
  bool initial=true;

  @override
  void initState() {
    // TODO: implement initState
    get_data();
    Store.save_music_timer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    //get_data();
    return Scaffold(
      body: SafeArea(
          child:  Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height-MediaQuery.of(context).padding.top,
            color: Colors.black87,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(onPressed: (){
                        Navigator.pop(context);
                      }, icon: Icon(Icons.arrow_back_ios,color: Colors.white,)),
                      Text("MUSIC",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
                      IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios,color: Colors.transparent,)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*0.3,
                    child: Image.asset("assets/CD.gif",fit: BoxFit.cover,),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 15),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*0.5-MediaQuery.of(context).padding.top - 50,
                    child: !loading?ListView.builder(
                        itemCount: this.music.length,
                        itemBuilder: (context,index){
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: GestureDetector(
                              onTap: (){
                                setState(() {
                                  selected_music=index;
                                });
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width*0.9,
                                      color: Colors.transparent,
                                      child: Row(
                                        children: [
                                          Padding(padding: EdgeInsets.only(right: 10),
                                            child: Container(height: 30,width: 3,color:  selected_music==index?Colors.white:Colors.transparent,),
                                          ),
                                          Text(this.music[index].title!,style: TextStyle(color: selected_music==index?Colors.white:Colors.grey,fontSize: 20,fontWeight: FontWeight.bold),)
                                        ],
                                      ),
                                    ),
                                    /**
                                    Row(
                                      children: [
                                        Padding(padding: EdgeInsets.only(right: 10),
                                          child: Container(height: 30,width: 3,color:  selected_music==index?Colors.white:Colors.transparent,),
                                        ),
                                        Text(this.music[index].artist,style: TextStyle(color: selected_music==index?Colors.white:Colors.grey,fontSize: 15),)
                                      ],
                                    ),*/
                                  ],
                                ),
                              ),
                            ),
                          );
                        }):_loading(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: GestureDetector(
                    onTap: (){
                      add_music();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width*0.3,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25)
                      ),
                      child: Center(child: Text("ADD",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),)),
                    ),
                  )
                ),

              ],
            ),
          )
      ),
    );
  }


  get_data(){
    Connecter.check_internet().then((internet) {
      if(internet){
        if(this.music.isEmpty&&initial){
          setState(() {
            //initial=false;
            loading=true;
          });
          Connecter.show_songs().then((list) {
            setState(() {
              if(list.length>0){
                initial=false;
              }
              this.music.addAll(list);
              loading=false;
            });
          });
        }
      }else{
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const NoInternet()),
        );
      }
    });


  }

  /*get_data(){
    Connecter.check_internet().then((internet) {
      if(internet){
        if(this.music.isEmpty&&initial){
          setState(() {
            //initial=false;
            loading=true;
          });
          WordPressConnecter.get_music().then((list) {
            setState(() {
              if(list.length>0){
                initial=false;
              }
              this.music.addAll(list);
              loading=false;
            });
          });
        }
      }else{
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const NoInternet()),
        );
      }
    });


  }*/
  _loading(){
    return Center(
      child: CircularProgressIndicator(),
    );
  }
  add_music(){
    Connecter.music_record(this.music[selected_music].link!, this.music[selected_music].title!).then((value){
      if(value == -1){
       // App.err_msg(context, 'Something went wrong');
      }else{
        int time = 4 * value;
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context){
            return WillPopScope(
              onWillPop: ()async => false,
              child: _alertDialog(context,'Your song added successfully\nRemaining time to play ≈ $time minutes' ),
            );
          }
        );
        //App.succ_msg(context, 'Remaining time to play ≈ $time minutes');
      }
    });
    setState(() {
      //ToDO add musicc timer
      ///Global.had_music=true;
      Global.music_timer=DateTime.now().toString();
    });

    //Navigator.of(context).pop();
  }

  _alertDialog(context,msg){
    return AlertDialog(
      title: Text(msg),
      actions: [
        GestureDetector(
          onTap: (){
            //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>PickChoose()));
            Navigator.pop(context);
            Navigator.pop(context);
          },
          child: Text('Done',style: TextStyle(fontSize: 20),),
        ),
      ],
    );
  }
}
