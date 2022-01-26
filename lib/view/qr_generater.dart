import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRGenerater extends StatefulWidget {
  String data;
  QRGenerater(this.data);

  @override
  _QRGeneraterState createState() => _QRGeneraterState(this.data);
}

class _QRGeneraterState extends State<QRGenerater> {
  String data;
  _QRGeneraterState(this.data);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: QrImage(
              data: this.data,
              version: QrVersions.auto,
              size: MediaQuery.of(context).size.width*0.7,
            ),
          ),
        ),
      ),
    );
  }
}
