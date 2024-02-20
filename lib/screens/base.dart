import 'package:flutter/material.dart';
import 'package:zatca/constant/app_size.dart';
import 'package:zatca/constant/colors.dart';
import 'package:zatca/constant/images.dart';
import 'package:zatca/helper/appWidget.dart';
class Base extends StatefulWidget {
  Widget child;
  Base({super.key, required this.child});

  @override
  State<Base> createState() => _BaseState();
}

class _BaseState extends State<Base> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Column(
        children:
        [
          Container(
            height: AppHeight.h14,
            decoration: const BoxDecoration(
              color: AppColors.mainColor,
            ),
            padding: EdgeInsets.only(left: AppWidth.w4, top: AppHeight.h5, bottom: AppHeight.h1),
            child: Row(
              children: [
                Image.asset(ImagesPath.logo, height: AppHeight.h8,),
                AppWidget.headText('ENOC', color: AppColors.whiteColor, scale: 1.2, padding: AppWidth.w2),
              ],
            ),
          ),
          widget.child,
        ]
      ),
    );
  }
}
