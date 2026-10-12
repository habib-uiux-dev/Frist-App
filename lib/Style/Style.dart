import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

const colorRed=Color.fromRGBO(231, 28, 36, 1);
const colorGreen=Color.fromRGBO(33, 191, 115, 1);
const colorWhite=Color.fromRGBO(255, 255, 255, 1);
const colorDarkBlue=Color.fromRGBO(44, 62, 80, 1);


SliverGridDelegateWithFixedCrossAxisCount ProductGridGridViewStyle() {
  return const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisSpacing: 2,
      mainAxisExtent: 250
  );
}

SvgPicture SrceenBackground(context){
  return SvgPicture.asset('assets/Images/Habib2.svg',
    alignment: Alignment.center,
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    fit: BoxFit.cover,
  );
}

InputDecoration AppInputDecoration(String labelText) {
  return InputDecoration(
    focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: colorGreen,width: 1)
    ),
    fillColor: colorWhite,
    filled: true,
    contentPadding: const EdgeInsets.fromLTRB(20, 10, 10, 20),
    enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: colorWhite,width: 0)
    ),
    border: const OutlineInputBorder(),
    labelText: labelText,
  );
}

DecoratedBox AppDropStyle(Widget child) {
  return DecoratedBox(
    decoration: BoxDecoration(
        color: Colors.white,border: Border.all(color: colorWhite,width: 1),
        borderRadius: BorderRadius.circular(4)
    ),
    child: Padding(
      padding: const EdgeInsets.only(left: 30, right: 30) ,
      child: child,
    ),
  );
}

ButtonStyle AppButtonStyle() {
  return ElevatedButton.styleFrom(
    backgroundColor: colorDarkBlue,
    foregroundColor: colorWhite,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    padding: const EdgeInsets.symmetric(vertical: 12),
  );
}

void ErrorToast(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0
  );
}