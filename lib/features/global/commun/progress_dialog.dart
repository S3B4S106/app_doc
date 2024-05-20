import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class ProgressDialog{
  static void show (BuildContext context){
     showCupertinoModalPopup(context: context, builder: (_)=>PopScope(child: Container(width: double.infinity,height: double.infinity,color: Colors.black12,alignment: Alignment.center,child: CircularProgressIndicator(),), canPop: false,));
  }
}