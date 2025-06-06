import 'dart:io';

import 'package:elgin/components/enums.dart';
import 'package:elgin/components/exceptions/elgin_exception.dart';
import 'package:flutter/services.dart';

///*Printer
///
///This class willl implement everything that we can you with the printer
class Printer {
  static MethodChannel? platform;
  static Printer? _instance;
  Printer._();

  ///*beep
  ///
  ///Just send a beep (some devices can't do that)
  Future<int> beep(int times, int st, int ft) async {
    Map<String, dynamic> mapParam = {};
    mapParam['times'] = times;
    mapParam['st'] = st;
    mapParam['ft'] = ft;
    int? beep = await platform?.invokeMethod("beep", {'beepArgs': mapParam}) ?? 9999;
    if (beep < 0) {
      throw ElginException(beep);
    }
    return beep;
  }

  ///*connect
  ///
  ///Connect the printer to use the methods below
  Future<int?> connect({required ElginPrinter driver}) async {
    Map<String, dynamic> mapParam = {};
    mapParam['type'] = driver.type.value;
    if (driver.type == ElginPrinterType.TCP) {}
    mapParam['model'] = driver.model?.value ?? 'M8';
    mapParam['connection'] = driver.connection ?? '';
    mapParam['param'] = driver.parameter ?? 0;
    int? connect = await platform?.invokeMethod('startInternalPrinter', {'printerArgs': mapParam}) ?? 9999;
    if (connect < 0) {
      throw ElginException(connect);
    }
    return connect;
  }

  ///*disconnect
  ///
  ///Disconnect the printer
  Future<int?> disconnect() async {
    int? disconnect = ((await platform?.invokeMethod('stopPrinter') ?? false) == false ? -1 : 9999);
    if (disconnect < 0) {
      throw ElginException(disconnect);
    }

    return disconnect;
  }

  ///*printXMLSAT
  ///
  ///Print a SAT XML with some parameters
  Future<int?> printSAT(String xml, {int param = 0}) async {
    Map<String, dynamic> mapParam = {};
    mapParam['xmlSAT'] = xml;
    mapParam['param'] = param;
    int? printSAT = await platform?.invokeMethod("printSAT", {'satArgs': mapParam}) ?? 9999;
    if (printSAT < 0) {
      throw ElginException(printSAT);
    }
    return printSAT;
  }

  ///*printXMLSAT
  ///
  ///Print a SAT XML with some parameters
  Future<int?> printNFCE(String xml, String csc, int cscId, {int param = 0}) async {
    Map<String, dynamic> mapParam = {};
    mapParam['xmlNFCe'] = xml;
    mapParam['indexcsc'] = cscId;
    mapParam['csc'] = csc;
    mapParam['param'] = param;
    int? printNfce = await platform?.invokeMethod("printNFCE", {'nfceArgs': mapParam}) ?? 9999;
    if (printNfce < 0) {
      throw ElginException(printNfce);
    }
    return printNfce;
  }

  ///*printTEF
  ///
  ///Print a SAT XML with some parameters
  Future<int?> printTEF(String cupomTEF) async {
    int? printTEF = await platform?.invokeMethod("printTEF", {'cupomTEF': cupomTEF}) ?? 9999;
    if (printTEF < 0) {
      throw ElginException(printTEF);
    }
    return printTEF;
  }

  ///*customCashier
  ///
  ///If you can open the cashiers that is not elgin, you can set the configurations and open
  Future<int> customCashier(int pin, int it, int dp) async {
    Map<String, dynamic> mapParam = {};
    mapParam['pin'] = pin;
    mapParam['it'] = it;
    mapParam['dp'] = dp;
    int? customCash = await platform?.invokeMethod("customCashier", {'cashierArgs': mapParam}) ?? 9999;

    if (customCash < 0) {
      throw ElginException(customCash);
    }
    return customCash;
  }

  ///*cut
  ///
  ///Cut a line and jump N lines before
  Future<int> cut({int lines = 0}) async {
    int? cut = await platform?.invokeMethod("cutPaper", {'lines': lines}) ?? 9999;

    if (cut < 0) {
      throw ElginException(cut);
    }
    return cut;
  }

  ///*elginCashier
  ///
  ///If you have an elgin cashier, you can just open it with this!
  Future<int> elginCashier() async {
    int? elginCash = await platform?.invokeMethod('elginCashier') ?? 9999;

    if (elginCash < 0) {
      throw ElginException(elginCash);
    }
    return elginCash;
  }

  ///*feed
  ///
  ///Jump n lines
  Future<int> feed(int lines) async {
    int? feed = await platform?.invokeMethod('feedLine', {'lines': lines}) ?? 9999;
    if (feed < 0) {
      throw ElginException(feed);
    }
    return feed;
  }

  ///*libVersion
  ///
  ///Show the version that the software is using at this moment
  Future<String> get libVersion async => await platform?.invokeMethod('libVersion');

  ///*line
  ///
  ///Just draw a simple line to divide some sectors in your print
  Future<void> line({String ch = '-', int len = 31}) async {
    await printString(List.filled(len, ch[0]).join());
  }

  ///*printBarCode
  ///
  ///Print a bar code with every [barcodeType] avaliable with size and [textPosition] , but some printers dont't allow that
  Future<int> printBarCode(String text, {EliginBarcodeType barcodeType = EliginBarcodeType.JAN8, ElginAlign align = ElginAlign.RIGHT, int height = 50, int width = 6, ElginBarcodeTextPosition textPosition = ElginBarcodeTextPosition.NO_TEXT}) async {
    await reset();
    Map<String, dynamic> mapParam = {};
    mapParam['barCodeType'] = barcodeType.value;
    mapParam['text'] = text;
    mapParam['height'] = height;
    mapParam['align'] = align.value;
    mapParam['width'] = width;
    mapParam['textPosition'] = textPosition.value;
    int? barcode = await platform?.invokeMethod("printBarCode", {'barcodeArgs': mapParam}) ?? 9999;
    if (barcode < 0) {
      throw ElginException(barcode);
    }
    return barcode;
  }

  ///*printImage
  ///
  ///You can print an image from web or from asset very easy with a [File]
  Future<int> printImage(File image, bool isBase64) async {
    await reset();
    Map<String, dynamic> mapParam = {};
    mapParam['path'] = image.path;
    mapParam['isBase64'] = isBase64;
    int? image0 = await platform?.invokeMethod('printImage', {'imageArgs': mapParam}) ?? 9999;
    if (image0 < 0) {
      throw ElginException(image0);
    }
    return image0;
  }

  ///*printQRCode
  ///
  ///Print a qrcode with some [correction], [align]  and [size]
  Future<int> printQRCode(String text, {ElginQrcodeSize size = ElginQrcodeSize.SIZE4, ElginAlign align = ElginAlign.CENTER, ElginQrcodeCorrection correction = ElginQrcodeCorrection.LEVEL_M}) async {
    await reset();
    Map<String, dynamic> mapParam = {};
    mapParam['size'] = size.value;
    mapParam['align'] = align.value;
    mapParam['correction'] = correction.value;
    mapParam['text'] = text;
    int? qrcode = await platform?.invokeMethod("printQrcode", {'qrcodeArgs': mapParam}) ?? 9999;
    if (qrcode < 0) {
      throw ElginException(qrcode);
    }
    return qrcode;
  }

  ///*printRaw
  ///
  ///This method you can send a raw esc/pos string to the printer. see the example folder for more instructions how to do it!
  Future<int> printRaw(List<int> rawList) async {
    await reset();
    Map<String, dynamic> mapParam = {};
    Uint8List list = Uint8List.fromList(rawList);
    mapParam['data'] = list;
    mapParam['bytes'] = list.lengthInBytes;
    int? raw = await platform?.invokeMethod('printRaw', {'rawArgs': mapParam}) ?? 9999;

    if (raw < 0) {
      throw ElginException(raw);
    }
    return raw;
  }

  ///*printString
  ///
  ///Just print a string in your paper with some [align], [fontSize], [font] and some others things
  Future<int> printString(String text, {ElginAlign align = ElginAlign.LEFT, @Deprecated('Não tem efeito real nas impressoras Elgin e será removido em versões futuras.') bool isBold = false, @Deprecated('Não tem efeito real nas impressoras Elgin e será removido em versões futuras.') bool isUnderline = false, ElginFont font = ElginFont.FONTA, ElginSize fontSize = ElginSize.MD}) async {
    await reset();
    Map<String, dynamic> mapParam = {};
    mapParam['text'] = text;
    mapParam['align'] = align.value;
    mapParam['font'] = font.value;
    mapParam['fontSize'] = fontSize.value;
    int? print = await platform?.invokeMethod('printText', {"textArgs": mapParam}) ?? 9999;
    if (print < 0) {
      throw ElginException(print);
    }
    feed(1);
    return print;
  }

  ///*reset
  ///
  ///This will just reset to the default status of the printer and will not clean any buffer
  Future<int> reset() async {
    int? reset = await platform?.invokeMethod('reset') ?? 9999;

    if (reset < 0) {
      throw ElginException(reset);
    }
    return reset;
  }

  ///*statusCashier
  ///
  ///Check if there is a chasier in the device or if it's working and everything else
  Future<int> statusCashier() async {
    int? status = await platform?.invokeMethod('statusCashier') ?? 9999;
    if (status < 0) {
      throw ElginException(status);
    }
    return status;
  }

  ///*statusEjetor
  ///
  ///Check the status of the ejector hardware
  Future<int> statusEjetor() async {
    int? status = await platform?.invokeMethod('statusEjector') ?? 9999;
    if (status < 0) {
      throw ElginException(status);
    }
    return status;
  }

  ///*statusSensor
  ///
  ///Check the status of the paper sensor hardware
  Future<int> statusSensor() async {
    int? status = await platform?.invokeMethod('statusSensor') ?? 9999;

    if (status < 0) {
      throw ElginException(status);
    }
    return status;
  }

  ///*instance
  ///
  ///Grab same printer instance
  static Printer instance(MethodChannel methodChannel) {
    platform = methodChannel;
    _instance ??= Printer._();
    return _instance!;
  }
}
