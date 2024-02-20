import 'package:sunmi_printer_plus/enums.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';
import 'package:zatca/appVariable.dart';
class SunmiHelper{

  static Future<bool?> bindingPrinter() async {
    final bool? result = await SunmiPrinter.bindingPrinter();
    await SunmiPrinter.paperSize().then((int size) {
      printerBinding.paperSize = size;
    });

    await SunmiPrinter.printerVersion().then((String version) {
      printerBinding.printerVersion = version;
    });

    await SunmiPrinter.serialNumber().then((String serial) {
      printerBinding.serialNumber = serial;
    });
    printerBinding.printBinded = result??false;
    return result;
  }

  static init() async{
    await SunmiPrinter.initPrinter();
    await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
    await SunmiPrinter.startTransactionPrint(true);
  }

  static print( bytes) async{
    if(!printerBinding.printBinded){await bindingPrinter();}
    if(bytes != null){
      await init();
      await SunmiPrinter.printImage(bytes);
      await finish();
    }
  }


  static finish() async{
    await SunmiPrinter.lineWrap(1);
    await SunmiPrinter.line();
    await SunmiPrinter.lineWrap(2);
    await SunmiPrinter.cut();
    await SunmiPrinter.exitTransactionPrint(true);
  }
}
