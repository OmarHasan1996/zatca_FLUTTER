import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mirai/mirai.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';
import 'package:zatca/appVariable.dart';
import 'package:zatca/constant/font_size.dart';
import 'package:zatca/dataService.dart';
import 'package:zatca/helper/sunmiPrinterHelper.dart';
import 'package:zatca/screens/splash/splashScreen.dart';

void main() async{

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        title: 'Zatca',
        theme: ThemeData(
          primarySwatch: Colors.green,
          appBarTheme: AppBarTheme(
            iconTheme: const IconThemeData(color: Colors.white),
            titleTextStyle: TextStyle(
                fontSize: FontSize.s20,
                fontWeight: FontWeight.w400,
                color: Colors.black),
            color: Colors.green,
            foregroundColor: Colors.black,
            centerTitle: true,
            systemOverlayStyle: const SystemUiOverlayStyle(
              systemNavigationBarColor: Colors.black,
              statusBarColor: Colors.green,
              statusBarIconBrightness: Brightness.light,
              statusBarBrightness: Brightness.light,
            ),
          ),
        ),
        home: SplashScreen(),
      );
    }
    );
  }
}