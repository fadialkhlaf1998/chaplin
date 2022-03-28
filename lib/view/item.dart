import 'package:carousel_slider/carousel_slider.dart';
import 'package:chaplin_new_version/controler/store.dart';
import 'package:chaplin_new_version/model/global.dart';
import 'package:chaplin_new_version/model/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class Item extends StatefulWidget {
  Product product;

  Item(this.product){
    print('*');
    print(Global.wishlist.length);
    if(Global.wishlist.length==0){
      product.favorite=false;
    }
    for(int i=0;i<Global.wishlist.length;i++){
      if(Global.wishlist[i].id==product.id){
        product.favorite=true;
        Global.wishlist[i] = product;
        break;
      }else{
        product.favorite=false;
      }
    }
  }


  @override
  _ItemState createState() => _ItemState(product);
}

class _ItemState extends State<Item> {
  Product product;

  _ItemState(this.product);

  final GlobalKey<ScaffoldState> _key=GlobalKey<ScaffoldState>();
  int selder_selected=0;
  int count=1;
  double price=0.0;
  double total=0.0;
  int selected_size=0;

  /**test*/
  int bottom_sheet_price=2;
  double saved_total=0.0;

  @override
  void initState() {
    super.initState();
    setState(() {
      print(product.price);
      price=double.parse(product.price!);
      total=count*price;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
      backgroundColor: Colors.white,
      key: _key,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.91,
                child: Stack(
                  alignment: Alignment.topLeft,
                  children: <Widget>[
                    Positioned(
                      top: 0,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.35+60,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(product.images!.first.src!),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: const Padding(
                        padding:  EdgeInsets.only(left: 15, top: 18),
                        child: Icon(
                          Icons.arrow_back,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    /**details*/
                    Positioned(
                      bottom: 0,
                      child: Container(
                        padding: const EdgeInsets.only(top: 50),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height*0.56,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(50),topRight: Radius.circular(50))
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(left: 20),
                                        width: MediaQuery.of(context).size.width  * 0.6,
                                        //padding: const EdgeInsets.only(left: 20,right: 20),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              child: Text(
                                                this.product.name!,
                                                maxLines: 3,
                                                style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(top: 5),
                                              child: Text(
                                                "AED "+total.toString(),
                                                style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.red),),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width  * 0.4,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            SizedBox(width: 5,),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 0,left: 15,right: 10),
                                              child: GestureDetector(
                                                onTap: (){
                                                  if(count>1){
                                                    setState(() {
                                                      count--;
                                                      saved_total=count*price;
                                                      total=count*price;
                                                    });
                                                  }

                                                },
                                                child: Container(
                                                  width: 30,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.circular(50),
                                                      border: Border.all(color: Colors.black,width: 2)
                                                  ),
                                                  child: Center(
                                                    child: Container(
                                                      color: Colors.black,
                                                      width: 12,
                                                      height: 3,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Text(count.toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 0,left: 10,right: 15),
                                              child: GestureDetector(
                                                onTap: (){
                                                  setState(() {

                                                    count++;
                                                    saved_total=count*price;
                                                    total=count*price;
                                                    /*saved_total=count*price;
                                                    if( selected_size==0){
                                                      total=saved_total;
                                                    }else if( selected_size==1){
                                                      total=saved_total*1.2;
                                                    }else if( selected_size==2){
                                                      total=saved_total*1.5;
                                                    }else if( selected_size==3){
                                                      total=saved_total*2;
                                                    }*/

                                                  });
                                                },
                                                child: Container(
                                                    width: 30,
                                                    height: 30,
                                                    decoration: BoxDecoration(
                                                        color: Colors.black,
                                                        borderRadius: BorderRadius.circular(50),
                                                        border: Border.all(color: Colors.black,width: 2)
                                                    ),
                                                    child: Icon(Icons.add_outlined,color: Colors.white,)
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 5,),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  Divider(color: Colors.black45, thickness: 1,indent: MediaQuery.of(context).size.width * 0.08,endIndent: MediaQuery.of(context).size.width * 0.08, height: 50),
                                  Container(
                                    padding: const EdgeInsets.only(top: 20),
                                    width: MediaQuery.of(context).size.width * 0.8,
                                    child: Column(
                                      children: [
                                        this.product.description.toString().isNotEmpty ?
                                        Html(
                                          data: this.product.description!,
                                          style: {
                                          "body": Style(
                                            textAlign: TextAlign.center,
                                            fontSize: const FontSize(18),
                                          ),
                                          },
                                        ) : Text('There are\'t any description for this product', style: TextStyle(fontSize: 16),)
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.05),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: (){
                                        Global.add_to_order(this.product, count);
                                        Navigator.of(context).pop();
                                      },
                                      child: Container(
                                        width: MediaQuery.of(context).size.width*0.7,
                                        height: MediaQuery.of(context).size.height*0.08,
                                        decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius: BorderRadius.circular(15)
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                                height: MediaQuery.of(context).size.height*0.05,
                                                width:  MediaQuery.of(context).size.height*0.05,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: Colors.red,
                                                ),
                                                child: Center(child: Icon(Icons.shopping_cart_outlined),)),
                                            SizedBox(width: 10,),
                                            Text("Add to cart",style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold),),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    /**heart*/
                    Positioned(
                      top: MediaQuery.of(context).size.height*0.363-30,
                      right: MediaQuery.of(context).size.width*0.1,
                      child: GestureDetector(
                        onTap: (){
                          if(product.favorite){
                            setState(() {
                              product.favorite=false;
                            });
                            Store.remove_from_wishlist(product);
                            setState(() {
                              Global.wishlist;
                            });
                          }else{
                            setState(() {
                              product.favorite=true;
                            });
                            Store.add_to_wishlist(product);
                            setState(() {
                              Global.wishlist;
                            });
                          }
                        },
                        child: Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                          ),
                          child: Icon(product.favorite?Icons.favorite:Icons.favorite_border,color: Colors.white,size: 27),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            /**flaoting price*/
            Positioned(
                bottom: 0,
                right: MediaQuery.of(context).size.width*0.05-8,
                child: Center())
          ],
        ),
      ),
    );
  }
}
