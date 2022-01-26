import 'package:chaplin_new_version/main.dart';
import 'package:chaplin_new_version/model/global.dart';
import 'package:flutter/material.dart';

class Sucss extends StatefulWidget {
  const Sucss({Key? key}) : super(key: key);

  @override
  _SucssState createState() => _SucssState();
}

class _SucssState extends State<Sucss> {

  @override
  void initState() {
    Global.load_order();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:  Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height-MediaQuery.of(context).padding.top,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/login.png"),
                  fit: BoxFit.cover
              )
          ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("order completed",style: TextStyle(color:Colors.white,fontSize: 22,),),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15,right: 15,top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, "dashboard");
                          },
                        child: Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width*0.8,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color:Colors.white,width: 2)
                          ),
                          child: Center(child: Text("Done",style: TextStyle(color: Colors.white,fontSize: 18),)),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),


        ),
      ),
    );
  }
}
