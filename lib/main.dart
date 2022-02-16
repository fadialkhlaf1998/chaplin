import 'dart:math';
import 'package:chaplin_new_version/controler/connector.dart';
import 'package:chaplin_new_version/view/dashboard.dart';
import 'package:chaplin_new_version/view/favorite.dart';
import 'package:chaplin_new_version/view/intro.dart';
import 'package:chaplin_new_version/view/sign_in.dart';
import 'package:chaplin_new_version/view/sign_up.dart';
import 'package:chaplin_new_version/view/verification_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'helper/app_localization.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  static void set_local(BuildContext context , Locale locale){
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state!.set_locale(locale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  void set_locale(Locale locale){
    setState(() {
      _locale=locale;
    });
  }


  MaterialColor generateMaterialColor(Color color) {
    return MaterialColor(color.value, {
      50: tintColor(color, 0.9),
      100: tintColor(color, 0.8),
      200: tintColor(color, 0.6),
      300: tintColor(color, 0.4),
      400: tintColor(color, 0.2),
      500: color,
      600: shadeColor(color, 0.1),
      700: shadeColor(color, 0.2),
      800: shadeColor(color, 0.3),
      900: shadeColor(color, 0.4),
    });
  }

  Color tintColor(Color color, double factor) => Color.fromRGBO(
      tintValue(color.red, factor),
      tintValue(color.green, factor),
      tintValue(color.blue, factor),
      1);

  int tintValue(int value, double factor) =>
      max(0, min((value + ((255 - value) * factor)).round(), 255));

  Color shadeColor(Color color, double factor) => Color.fromRGBO(
      shadeValue(color.red, factor),
      shadeValue(color.green, factor),
      shadeValue(color.blue, factor),
      1);

  int shadeValue(int value, double factor) =>
      max(0, min(value - (value * factor).round(), 255));

  Locale? _locale;

  @override
  void initState() {
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        String lang=prefs.getString("language")??'en';
          _locale=Locale(lang,'');
      });
    });
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: {
          'signIn': (context) => Sign_In(),
          'signUp': (context) => SignUp(),
          'code': (context) => VerificationCode(),
          'dashboard': (context) => DashBoard(),
          'favorite' : (context) => Favorite(),
        },
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: generateMaterialColor(Colors.grey),
          fontFamily: 'BebasNeue'
      ),
      locale: _locale,
      supportedLocales: [Locale('en', ''), Locale('ar', '')],
      localizationsDelegates: [
        App_Localization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (local, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == local!.languageCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      home:Gif()//MusicView()
      //Gif()
      //QRGenerater("fadi_alkhlaf1998@maxart.chaplin")
      //QRScanner()
      //QRGenerater("1234567890")
      //MyPoints()
      //Favorite(),
      //Sign_In(),
      //Music()
      //Item()
      //DashBoard(),
      //PhotoPicker()
    );
  }
}


class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {

  Map<String, dynamic> data = {
  "payment_method": "bacs",
  "payment_method_title": "Direct Bank Transfer",
  "set_paid": true,
  "billing": {
  "first_name": "adnan",
  "last_name": "kiswani",
  "address_1": "969 Market",
  "address_2": "",
  "city": "San Francisco",
  "state": "CA",
  "postcode": "94103",
  "country": "US",
  "email": "ad.kw@example.com",
  "phone": "(555) 151-8979"
  },
  "shipping": {
  "first_name": "adnan",
  "last_name": "kiswani",
  "address_1": "969 Market",
  "address_2": "",
  "city": "San Francisco",
  "state": "CA",
  "postcode": "94103",
  "country": "US"
  },
  "line_items": [
  {
  "product_id": 93,
  "quantity": 2
  },
  {
  "product_id": 22,
  "variation_id": 23,
  "quantity": 1
  }
  ],
  "shipping_lines": [
  {
  "method_id": "flat_rate",
  "method_title": "Flat Rate",
  "total": "10.00"
  }
  ]
  };

  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      drawer: Drawer(
        
      ),
      body: SafeArea(
        child: Container(

            color: Colors.white,
            child:
            Center(
              child: GestureDetector(
                onTap: ()async{
                  //WordPressConnecter.get_customer("fadi.kh38610130@gmail.com");
                  //print(data.toString());
                  //Product fromJson = Product.fromJson(json);
                  //print(fromJson.id);
                  Connecter.get_music_list();
                  // print('**************');
                  //WordPressConnecter.get_music();
                },
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle
                  ),
                  child: Icon(Icons.add),
                ),
              ),

              /**
              child:
                  PlacePicker(
                    apiKey: "AIzaSyAV108I2lxHUrkUBsuDSRL9ttsUISBCwsU",   // Put YOUR OWN KEY here.
                    onPlacePicked: (result) {
                      print('***');
                      print("result");
                      //Navigator.of(context).pop();
                    },
                    useCurrentLocation: true,
                    //enableMapTypeButton: true,
                    initialPosition: LatLng(-33.8567844, 151.213108),
                    /*useCurrentLocation: true,
                    selectInitialPosition: true,
                    enableMyLocationButton: true,
                    searchForInitialValue: false,*/



                  ),*/
                  /*
                  GestureDetector(
                    child: Container(
                      color: Colors.blue,
                      width: 100,
                      height: 50,
                    ),
                    onTap: ()async{
                      //LocationResult result = await showLocationPicker(context, "AIzaSyAV108I2lxHUrkUBsuDSRL9ttsUISBCwsU");
                    },
                  )*/
            )

        ),
      ),
    );
  }
}

/**
    GestureDetector(
    onTap: (){
    SharedPreferences.getInstance().then((prefs) {
    prefs.setString("language","ar");
    MyApp.set_local(context, Locale('ar',''));
    });
    },
    child: Container(
    width: 100,
    height: 50,
    child: Center(
    child: Text("ar"),
    ),
    ),
    ),
    GestureDetector(
    onTap: (){
    SharedPreferences.getInstance().then((prefs) {
    prefs.setString("language","en");
    MyApp.set_local(context, Locale('en',''));
    });
    },
    child: Container(
    width: 100,
    height: 50,
    child: Center(
    child: Text("en"),
    ),
    ),
    ),
    GestureDetector(
    onTap: (){
    SharedPreferences.getInstance().then((prefs) {
    prefs.setString("language","def");
    //MyApp.set_local(context, Locale('ar',''));
    });
    },
    child: Container(
    width: 100,
    height: 50,
    child: Center(
    child: Text("def"),
    ),
    ),
    ),
 */


