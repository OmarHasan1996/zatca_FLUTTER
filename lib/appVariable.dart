import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

late Map<String, dynamic> lastTransaction;

PrinterBinding printerBinding = PrinterBinding();


class PrinterBinding{
bool printBinded = false;
int paperSize = 0;
String serialNumber = "";
String printerVersion = "";
}