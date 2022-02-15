import 'dart:developer';
import 'dart:io';

import 'package:chaplin_new_version/model/global.dart';
import 'package:chaplin_new_version/view/complete_order.dart';
import 'package:chaplin_new_version/view/submit_complete_order.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

import 'music.dart';

class QRScanner extends StatefulWidget {
  const QRScanner({Key? key}) : super(key: key);

  @override
  _QRScannerState createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  bool initial=true;
  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() async{
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            _buildQrView(context),
                Positioned(child: IconButton(onPressed: (){
            Navigator.pop(context);
            }, icon: Icon(Icons.arrow_back_ios,color: Colors.white,),),)
          ],
        ),
      ),
    );
  }
 /* @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: (result != null)
                  ? Text(
                  'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                  : Text('Scan a code'),
            ),
          )
        ],
      ),
    );
  }*/
  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = MediaQuery.of(context).size.width*0.7;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.grey,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }
  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('no Permission')),
      );
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
      if(result!.code.toString().contains("123456789") && initial && Global.option == 0) {
        setState(() {
          initial=false;
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const MusicView()),
        );
      }

      else if(result!.code.toString().contains("_")&&result!.code.toString().contains("-")) {
        setState(() {
          initial=false;
        });
        openwhatsapp(context, result!.code.toString());
      } else if (result!.code.toString().contains("123456789") && initial && Global.option == 1){
        setState(() {
          initial=false;
        });
        Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const SubmitCompleteOrder()),);
      }
    });
  }


  static openwhatsapp(BuildContext context,String msg) async{
    String test = 'test';
    var whatsapp ="+971 52 692 4021";
    var whatsappURl_android = "https://api.whatsapp.com/send?phone=$whatsapp=${Uri.parse(msg)}";
    var whatappURL_ios ="https://wa.me/$whatsapp/?text=${Uri.parse(msg)}";

      // add the [https]
      if( await canLaunch(whatappURL_ios)){
        await launch(whatappURL_ios);
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: new Text("whatsapp no installed")));
      }
  }



  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
