import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyPoints extends StatefulWidget {
  const MyPoints({Key? key}) : super(key: key);

  @override
  _MyPointsState createState() => _MyPointsState();
}

class _MyPointsState extends State<MyPoints> {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: SingleChildScrollView(
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
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("My Points",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),)
                                      ],
                                    ),
                                  ),
                                  Positioned(child: IconButton(onPressed: (){
                                    Navigator.pop(context);
                                  }, icon: Icon(Icons.arrow_back,color: Colors.white,)),top: 10,)
                                ],
                              ),



                            ],
                          ),
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: 10,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Container(
                                  color: Colors.white,
                                  width: MediaQuery.of(context).size.width*0.9,
                                  height: 90,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(Icons.star,color: Colors.black87,size: 40,),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text("10 Points",style: TextStyle(fontSize: 20),),
                                          Text("Valid for two day",style: TextStyle(fontSize: 16,color: Colors.red),)
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text("",style: TextStyle(fontSize: 20),),
                                          GestureDetector(
                                            onTap: (){

                                            },
                                            child: Container(
                                              width: MediaQuery.of(context).size.width*0.2,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                  color: Colors.black87,
                                                  borderRadius: BorderRadius.circular(10)
                                              ),
                                              child: Center(
                                                child: Text("Replace",style: TextStyle(color: Colors.white),),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),

                                    ],
                                  ),
                                ),
                              );
                            }),
                        SizedBox(
                          height: MediaQuery.of(context).size.height*1/5,
                        )


                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(width: 1.0, color: Colors.grey),
              ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Replace them all",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold,fontSize: 18)),
                    GestureDetector(
                      onTap: (){

                      },
                      child: Container(
                        height: 40,
                        width: 120,
                        decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(Icons.star,color: Colors.white,),
                            Text("359 Points",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
