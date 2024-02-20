import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zatca/api_service.dart';
import 'package:zatca/constant/app_size.dart';
import 'package:zatca/constant/colors.dart';
import 'package:zatca/helper/appWidget.dart';
import 'package:zatca/helper/functions.dart';
import 'package:zatca/screens/base.dart';
import 'package:zatca/screens/transactionDetails/transactionScreen.dart';
class PumpScreen extends StatefulWidget {
  const PumpScreen({super.key});

  @override
  State<PumpScreen> createState() => _PumpScreenState();
}

class _PumpScreenState extends State<PumpScreen> {
  TextEditingController  _pumpNumber = new TextEditingController(text: "01");
  TextEditingController  _siteNumber = new TextEditingController(text: "1001");

  @override
  Widget build(BuildContext context) {
    return Base(
      child: Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppWidth.w6, vertical: AppHeight.h2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppWidget.bodyText('Site Number:'),
              AppWidget.textFormFiled(controller: _siteNumber),
              SizedBox(height: AppHeight.h1,),
              AppWidget.bodyText('Pump Number:'),
              AppWidget.textFormFiled(controller: _pumpNumber),
              const Spacer(),
              SizedBox(height: AppHeight.h2,),
              AppWidget.elevatedButton(text: 'GET', press: ()=> getTransaction(), backcolor: AppColors.mainColor2),
              SizedBox(height: AppHeight.h2,),
              AppWidget.elevatedButton(text: 'CLOSE', press: ()=> close(), backcolor: AppColors.mainColor3)
            ],
          ),
        ),
      ),
    );
  }

  close() {
    exit(0);
    //SystemNavigator.pop();
  }

  getTransaction() async{
    var result = await ApiService.getLastTransaction(pumpNumber: _pumpNumber.text, siteNumber: _siteNumber.text);
    if(result){
      MyApplication.navigateTo(context, TransactionScreen());
    }
  }
}
