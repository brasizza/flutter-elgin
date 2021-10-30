import 'dart:io';
import 'dart:typed_data';

import 'package:elgin/components/enums.dart';
import 'package:elgin/elgin.dart';
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
    Map<String, dynamic> mapParam = new Map();
    mapParam['times'] = times;
    mapParam['st'] = st;
    mapParam['ft'] = ft;
    return await platform?.invokeMethod("beep", {'beepArgs': mapParam});
  }

  ///*connect
  ///
  ///Connect the printer to use the methods below
  Future<int?> connect() async =>
      await platform?.invokeMethod('startInternalPrinter') ?? 0;

  ///*disconnect
  ///
  ///Disconnect the printer
  Future<int?> disconnect() async =>
      await platform?.invokeMethod('printerStop') ?? 0;

  ///*customCashier
  ///
  ///If you can open the cashiers that is not elgin, you can set the configurations and open
  Future<int> customCashier(int pin, int it, int dp) async {
    Map<String, dynamic> mapParam = new Map();
    mapParam['pin'] = pin;
    mapParam['it'] = it;
    mapParam['dp'] = dp;
    return await platform
        ?.invokeMethod("customCashier", {'cashierArgs': mapParam});
  }

  ///*cut
  ///
  ///Cut a line and jump N lines before
  Future<int> cut({int lines = 0}) async =>
      await platform?.invokeMethod("cutPaper", {'lines': lines});

  ///*elginCashier
  ///
  ///If you have an elgin cashier, you can just open it with this!
  Future<int> elginCashier() async =>
      await platform?.invokeMethod('elginCashier');

  ///*feed
  ///
  ///Jump n lines
  Future<int> feed(int lines) async =>
      await platform?.invokeMethod('feedLine', {'lines': lines});

  ///*libVersion
  ///
  ///Show the version that the software is using at this moment
  Future<String> get libVersion async =>
      await platform?.invokeMethod('libVersion');

  ///*line
  ///
  ///Just draw a simple line to divide some sectors in your print
  Future<void> line({String ch = '-', int len = 31}) async {
    await reset();
    await printString(List.filled(len, ch[0]).join());
  }

  ///*printBarCode
  ///
  ///Print a bar code with every [barcodeType] avaliable with size and [textPosition] , but some printers dont't allow that
  Future<int> printBarCode(String text,
      {EliginBarcodeType barcodeType = EliginBarcodeType.JAN8,
      ElginAlign align = ElginAlign.RIGHT,
      int height = 50,
      int width = 6,
      ElginBarcodeTextPosition textPosition =
          ElginBarcodeTextPosition.NO_TEXT}) async {
    await reset();
    Map<String, dynamic> mapParam = new Map();
    mapParam['barCodeType'] = barcodeType.value;
    mapParam['text'] = text;
    mapParam['height'] = height;
    mapParam['align'] = align.value;
    mapParam['width'] = width;
    mapParam['textPosition'] = textPosition.value;
    return await platform
        ?.invokeMethod("printBarCode", {'barcodeArgs': mapParam});
  }

  ///*printImage
  ///
  ///You can print an image from web or from asset very easy with a [File]
  Future<int> printImage(File image, bool isBase64) async {
    await reset();
    Map<String, dynamic> mapParam = new Map();
    mapParam['path'] = image.path;
    mapParam['isBase64'] = isBase64;
    return await platform?.invokeMethod('printImage', {'imageArgs': mapParam});
  }

  ///*printQRCode
  ///
  ///Print a qrcode with some [correction], [align]  and [size]
  Future<int> printQRCode(
    String text, {
    ElginQrcodeSize size = ElginQrcodeSize.SIZE4,
    ElginAlign align = ElginAlign.CENTER,
    ElginQrcodeCorrection correction = ElginQrcodeCorrection.LEVEL_M,
  }) async {
    await reset();
    Map<String, dynamic> mapParam = new Map();
    mapParam['size'] = size.value;
    mapParam['align'] = align.value;
    mapParam['correction'] = correction.value;
    mapParam['text'] = text;
    return await platform
        ?.invokeMethod("printQrcode", {'qrcodeArgs': mapParam});
  }

  ///*printRaw
  ///
  ///This method you can send a raw esc/pos string to the printer. see the example folder for more instructions how to do it!
  Future<int> printRaw(List<int> rawList) async {
    await reset();
    Map<String, dynamic> mapParam = new Map();
    Uint8List _list = Uint8List.fromList(rawList);
    mapParam['data'] = _list;
    mapParam['bytes'] = _list.lengthInBytes;
    return await platform?.invokeMethod('printRaw', {'rawArgs': mapParam});
  }

  ///*printString
  ///
  ///Just print a string in your paper with some [align], [fontSize], [font] and some others things
  Future<int> printString(
    String text, {
    ElginAlign align = ElginAlign.LEFT,
    bool isBold = false,
    bool isUnderline = false,
    ElginFont font = ElginFont.FONTA,
    ElginSize fontSize = ElginSize.MD,
  }) async {
    await reset();
    Map<String, dynamic> mapParam = new Map();
    mapParam['text'] = text;
    mapParam['align'] = align.value;
    mapParam['isBold'] = isBold;
    mapParam['isUnderline'] = isUnderline;
    mapParam['font'] = font.value;
    mapParam['fontSize'] = fontSize.value;
    mapParam['typePrinter'] = "printerText";
    return await platform?.invokeMethod('printText', {"textArgs": mapParam});
  }

  ///*reset
  ///
  ///This will just reset to the default status of the printer and will not clean any buffer
  Future<int> reset() async {
    return await platform?.invokeMethod('reset');
  }

  ///*statusCashier
  ///
  ///Check if there is a chasier in the device or if it's working and everything else
  Future<int> statusCashier() async =>
      await platform?.invokeMethod('statusCashier');

  ///*statusEjetor
  ///
  ///Check the status of the ejector hardware
  Future<int> statusEjetor() async =>
      await platform?.invokeMethod('statusEjector');

  ///*statusSensor
  ///
  ///Check the status of the paper sensor hardware
  Future<int> statusSensor() async =>
      await platform?.invokeMethod('statusSensor');

  ///*instance
  ///
  ///Grab same printer instance
  static Printer instance(MethodChannel methodChannel) {
    platform = methodChannel;
    _instance ??= Printer._();
    return _instance!;
  }
}
