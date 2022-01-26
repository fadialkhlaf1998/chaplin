import 'package:chaplin_new_version/controler/connector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoInternet extends StatefulWidget {
  const NoInternet({Key? key}) : super(key: key);

  @override
  _NoInternetState createState() => _NoInternetState();
}

class _NoInternetState extends State<NoInternet> {
  bool request=true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          !request?
             Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 CircularProgressIndicator()
               ],
             )
          :Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.wifi_off,size: 100,),
              Text("No Internet",style: TextStyle(fontSize: 16,color: Colors.black87,fontWeight: FontWeight.bold)),
              SizedBox(height: 5,),
              GestureDetector(
                child: Container(width: 100,height: 35,
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text("Reload",style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),),
                  ),
                ),
                onTap: (){
                  setState(() {
                    request=false;
                  });
                  Connecter.check_internet().then((internet) {
                    if(internet){
                      Navigator.pop(context);
                    }else{
                      setState(() {
                        request=true;
                      });
                    }
                  });
                },
              )
            ],
          ),
        ],
      )),
    );
  }
}
