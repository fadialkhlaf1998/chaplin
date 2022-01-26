import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';

class App{

  static succ_msg(BuildContext context,String msg){
    return showTopSnackBar(
      context,
      CustomSnackBar.success(
        message:
        msg,
      ),
    );
  }
  static err_msg(BuildContext context,String msg){
    return showTopSnackBar(
      context,
      CustomSnackBar.error(
        message:
        msg,
      ),
    );
  }
}