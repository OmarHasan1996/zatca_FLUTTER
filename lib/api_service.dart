import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';


import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:zatca/appVariable.dart';
import 'package:zatca/constant/app_size.dart';
import 'package:zatca/constant/colors.dart';
import 'package:zatca/constant/font_size.dart';
import 'package:zatca/helper/appWidget.dart';

import 'main.dart';


class ApiService {
  Future<bool> checkConnection() async {
    try {
      final result = await InternetAddress.lookup('beitalkhair.org')
          .timeout(const Duration(seconds: 5));
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }

  static dialogBuilder(text) {
    if (navigatorKey.currentContext != null) {
      return showDialog<void>(
        context: navigatorKey.currentContext!,
        builder: (BuildContext context) {
          return Dialog(
            //title: const CloseButton(),
            backgroundColor: Colors.transparent,
            child: Container(
              height: AppHeight.h70,
              padding: EdgeInsets.symmetric(
                  horizontal: AppPadding.p10, vertical: AppPadding.p20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(AppWidth.w4)),
                color: AppColors.mainColor.withOpacity(0.9),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.info_outline_rounded,
                      size: AppHeight.h10,
                      color: AppColors.whiteColor,
                    ),
                    SizedBox(
                      height: AppHeight.h1,
                    ),
                    Image.memory(Uint8List.fromList(text)),
                    //AppWidget.bodyText(text, scale: 0.7, maxLine: 7, color: AppColors.whiteColor),
                    SizedBox(
                      height: AppHeight.h1,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: AppPadding.p20),
                      child: AppWidget.elevatedButton(
                          text: 'Close',
                          press: () => Navigator.of(context).pop(),
                          backcolor: AppColors.mainColor2,
                          height: AppHeight.h4,
                          fontSize: FontSize.s16),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
  }

  static var _waitOpen = false;
  static waitDialog() {
    _waitOpen = true;
    showGeneralDialog(
      context: navigatorKey.currentContext!,
      barrierColor: Colors.black12.withOpacity(0.6), // Background color
      barrierDismissible: false,
      barrierLabel: 'Dialog',
      transitionDuration: const Duration(milliseconds: 100),
      pageBuilder: (_, __, ___) {
        return Column(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Container(
                height: double.infinity,
                  width: double.infinity,
                  color: AppColors.whiteColor.withOpacity(0.01),
                  // padding: EdgeInsets.symmetric(horizontal: AppWidth.w100 / 3, vertical: AppHeight.h100 / 3),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: AppWidth.w30, width: AppWidth.w30, child: const CircularProgressIndicator()),
                    ],
                  )),
            ),
          ],
        );
      },
    );
  }

  static navPop({bool force = false}) {
    if (_waitOpen == true || force) {
      Navigator.pop(navigatorKey.currentContext!);
      _waitOpen = false;
    }
  }

  static Future<bool> getLastTransaction({required String pumpNumber, required String siteNumber, String system="FUEL"}) async{
    waitDialog();
    var headers = {
      'Cookie': 'BIGipServerPL-retailqaho.enoc.com-4447=!9UQX3TUL+TbHF1ERFbXcpoZ1aS+I/vT0o2SKxHT9JSwia7SC0b8qMwkUVc73nvwYJtyJxsFXndWWUg==; TS018ac1cf=0197ead0326e28b3aaf0bc70c304c6c5e34b2ab5347dfa8409ff314d08e98e831d84144be5e2737fa2820bbbb268a6f477c0ae1994',
      'X-Gateway-ApiKey': '0277a6d2-6963-4378-8bed-6becf919deb9',
      'Content-Type': 'application/json'
    };
    var data = json.encode({
      "pumpNumber": pumpNumber,
      "siteNumber": siteNumber,
      "system": system
    });
    var dio = Dio();
    var response = await dio.request(
      'https://qaapiservices.enoc.com/ext/receipt/v1/transactions/getList',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );
    navPop();
    if (response.statusCode == 200) {
      print(json.encode(response.data));
      lastTransaction = response.data['response']['data'][0];
      return true;
    }
    else {
      print(response.statusMessage);
    }
    return false;
  }

  final List<Color> _colorList = [
    AppColors.mainColor2,
    AppColors.orang,
    AppColors.blueColor,
    AppColors.bodyText,
    AppColors.mainColor,
    AppColors.red,
    AppColors.mainColor2,
    AppColors.orang,
    AppColors.blueColor,
    AppColors.bodyText,
    AppColors.mainColor,
    AppColors.red,
    AppColors.mainColor2,
    AppColors.orang,
    AppColors.blueColor,
    AppColors.bodyText,
    AppColors.mainColor,
    AppColors.red,
    AppColors.mainColor2,
    AppColors.orang,
    AppColors.blueColor,
    AppColors.bodyText,
    AppColors.mainColor,
    AppColors.red,
    AppColors.mainColor2,
    AppColors.orang,
    AppColors.blueColor,
    AppColors.bodyText,
    AppColors.mainColor,
    AppColors.red,
    AppColors.mainColor2,
    AppColors.orang,
    AppColors.blueColor,
    AppColors.bodyText,
    AppColors.mainColor,
    AppColors.red,
  ];

}
