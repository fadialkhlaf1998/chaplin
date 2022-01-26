import 'package:chaplin_new_version/controler/connector.dart';
import 'package:chaplin_new_version/controler/wordpress_connector.dart';
import 'package:chaplin_new_version/model/global.dart';
import 'package:chaplin_new_version/model/order.dart';
import 'package:chaplin_new_version/view/dashboard.dart';
import 'package:chaplin_new_version/view/fail.dart';
import 'package:chaplin_new_version/view/no_internet.dart';
import 'package:chaplin_new_version/view/shipping.dart';
import 'package:chaplin_new_version/view/sign_in.dart';
import 'package:chaplin_new_version/view/sign_up.dart';
import 'package:chaplin_new_version/view/sucss.dart';
import 'package:chaplin_new_version/view/verification_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:my_fatoorah/my_fatoorah.dart';

/*
class MyFatoorahPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'signIn': (context) => Sign_In(),
        'signUp': (context) => SignUp(),
        'code': (context) => VerificationCode(),
        'dashboard': (context) => DashBoard(),
      },
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      locale: Locale('ar'),
      supportedLocales: [
        const Locale('ar'),
      ],
      home: InnerPage(),
    );
  }
}*/

class InnerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('دفع ماى فاتورة'),
        actions: [
          IconButton(
              icon: Icon(Icons.payment),
              onPressed: () {
                MyFatoorah.startPayment(
                  context: context,
                  errorChild: Center(
                    child: Icon(
                      Icons.error,
                      color: Colors.redAccent,
                      size: 50,
                    ),
                  ),
                  succcessChild: Center(
                    child: Icon(
                      Icons.done_all,
                      color: Colors.greenAccent,
                      size: 50,
                    ),
                  ),
                  request: MyfatoorahRequest.test(
                    token:
                    'rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL',
                    currencyIso: Country.UAE,
                    successUrl:
                    'https://assets.materialup.com/uploads/473ef52c-8b96-46f7-9771-cac4b112ae28/preview.png',
                    errorUrl:
                    'https://www.digitalpaymentguru.com/wp-content/uploads/2019/08/Transaction-Failed.png',
                    invoiceAmount: Global.total,
                    language: ApiLanguage.Arabic,
                  ),
                ).then((response) {
                  print(response);
                }).catchError((e) {
                  print(e);
                });
              })
        ],
      ),
      body: Builder(
        builder: (BuildContext context) {
          return MyFatoorah(
            directPayment: (callBack) => Scaffold(
              appBar: AppBar(),
              body: Center(
                child: ElevatedButton(
                  onPressed: () {
                    callBack(DirectPayment(
                      card: CardInfo(
                        expiryMonth: '12',
                        expiryYear: '25',
                        holderName: 'test test',
                        number: '5453010000095539',
                        securityCode: '300',
                      ),

                      paymentType: 'card',
                    )).then((value) {

                    });
                  },
                  child: Text('Direct payment'),
                ),
              ),
            ),
            buildAppBar: (callback) => AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).maybePop();
                },
              ),
            ),
            request: MyfatoorahRequest.test(
              token:
              'rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL',
              currencyIso: Country.UAE,
              successUrl:
              'https://assets.materialup.com/uploads/473ef52c-8b96-46f7-9771-cac4b112ae28/preview.png',
              errorUrl:
              'https://www.digitalpaymentguru.com/wp-content/uploads/2019/08/Transaction-Failed.png',
              invoiceAmount: Global.total,
              language: ApiLanguage.Arabic,
            ),

            errorChild: Center(
              child: Icon(
                Icons.error,
                color: Colors.redAccent,
                size: 50,
              ),
            ),
            succcessChild: Center(
              child: Icon(
                Icons.done_all,
                color: Colors.greenAccent,
                size: 50,
              ),
            ),
            onResult: (PaymentResponse res) {
              if(res.status==PaymentStatus.Success){
                creat_myfatoorah_order(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Sucss()),
                );
              }else{
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Fail()),
                );
              }

            },
          );
        },
      ),
    );
  }
  creat_myfatoorah_order(BuildContext context){
    Order order=Global.get_order();
    order.billing=Global.customer!.billing;
    order.shipping=Global.customer!.shipping;
    WordPressConnecter.post_order(order.toMap());
    //ToDo ask adel for that
    order.setPaid=true;
    order.paymentMethod="bacs";
    order.paymentMethod="Direct Bank Transfer";

    Connecter.check_internet().then((value) {
      if(!value){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NoInternet()),
        ).then((value) {
          creat_myfatoorah_order(context);
        });

      }else{
        WordPressConnecter.post_order(order.toMap()).then((deliver) {

          if(deliver){


          }else{
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Fail()),
            );

          }
        });
      }
    });

  }
}