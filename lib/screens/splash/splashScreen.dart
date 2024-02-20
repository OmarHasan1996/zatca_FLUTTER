import 'dart:async';

import 'package:flutter/material.dart';
import 'package:zatca/api_service.dart';
import 'package:zatca/constant/app_size.dart';
import 'package:zatca/constant/images.dart';
import 'package:zatca/helper/functions.dart';
import 'package:zatca/screens/pump/pumpScreen.dart';
class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);
  @override
  void dispose() {

  }

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(milliseconds: 100), () async {
      bool t = await ApiService().checkConnection();
      if (!t) {
        MyApplication.navigateTo(context, const PumpScreen());
        return;
      }
      await read();
      MyApplication.navigateToReplace(context, PumpScreen());
    });
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        margin: EdgeInsets.all(AppPadding.p20),
        decoration: const BoxDecoration(image: DecorationImage(image: AssetImage(ImagesPath.splashLogo), fit: BoxFit.contain)),
      ),
    );
  }

  read() async {

  }
}