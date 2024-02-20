import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:zatca/api_service.dart';

import 'package:zatca/appVariable.dart';
import 'package:zatca/constant/app_size.dart';
import 'package:zatca/constant/colors.dart';
import 'package:zatca/helper/appWidget.dart';
import 'package:zatca/helper/sunmiPrinterHelper.dart';
import 'package:zatca/screens/base.dart';
class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  List<ItemValue> _itemList = [];
  List<Widget> _printerPage = [];
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => _afterBuild());  // TODO: implement initState
    super.initState();
    lastTransaction.forEach((k, v) => {if(v!= null && v!=0) _itemList.add(ItemValue(item: k, value: v.toString()))});
    _itemList.forEach((e) {_printerPage.add(_itemContainer(item: e.item, value: e.value));});
  }

  @override
  Widget build(BuildContext context) {
    return Base(
        child: Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: AppWidth.w6, right: AppWidth.w6, bottom: AppHeight.h2),
            child: Column(
              children: [
                Expanded(
                    child: SingleChildScrollView(
                      child: RepaintBoundary(
                        key: _globalKey,
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            children: _printerPage,
                          ),
                        ),
                      ),
                    )
                ),
                SizedBox(height: AppHeight.h2,),
                AppWidget.elevatedButton(text: 'PRINT', press: ()=> print(), backcolor: AppColors.mainColor2),
                SizedBox(height: AppHeight.h2,),
                AppWidget.elevatedButton(text: 'CLOSE', press: ()=> close(), backcolor: AppColors.mainColor3)
              ],
            ),
          ),
        )
    );
  }

  close() {
    Navigator.pop(context);
  }
  final GlobalKey _globalKey = new GlobalKey();

  Future<Uint8List?> _capturePng() async {
    try {
      debugPrint('inside');
      final RenderRepaintBoundary boundary = _globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
      final ui.Image image = await boundary.toImage(pixelRatio: 1.2);
      final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png, );
      final Uint8List? pngBytes = byteData?.buffer.asUint8List();
      return pngBytes;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  print() async{
    //ApiService.dialogBuilder(await _capturePng());
    await SunmiHelper.print(await _capturePng());
  }

  Widget _itemContainer({required String item, required String value,}){
    return Column(
      children: [
        Row(
          children: [
            AppWidget.bodyText('$item: ', scale: 0.9, padV: 0.0),
            Expanded(child: AppWidget.bodyText(value, maxLine: 2, align: TextAlign.right, scale: 0.8, padV: 0.0)),
          ],
        ),
        const Divider(),
      ],
    );
  }

  _afterBuild() async{
    if(!printerBinding.printBinded) await SunmiHelper.bindingPrinter();
    _printerPage.add(QrImageView(
      data: printerBinding.printBinded?"${printerBinding.serialNumber}V.${printerBinding.printerVersion}":'Not Printer',
      version: QrVersions.auto,
      size: 200.0,));
    setState(() {});
  }


}
class ItemValue{
  String item;
  String value;
  ItemValue({required this.item, required this.value});
}
