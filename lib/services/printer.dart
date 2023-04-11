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
    Map<String, dynamic> mapParam = new Map();
    mapParam['times'] = times;
    mapParam['st'] = st;
    mapParam['ft'] = ft;
    int? _beep =
        await platform?.invokeMethod("beep", {'beepArgs': mapParam}) ?? 9999;
    if (_beep < 0) {
      throw ElginException(_beep);
    }
    return _beep;
  }

  ///*connect
  ///
  ///Connect the printer to use the methods below
  Future<int?> connect({required ElginPrinter driver}) async {
    Map<String, dynamic> mapParam = new Map();
    mapParam['type'] = driver.type.value;
    if (driver.type == ElginPrinterType.TCP) {}
    mapParam['model'] = driver.model?.value ?? 'M8';
    mapParam['connection'] = driver.connection ?? '';
    mapParam['param'] = driver.parameter ?? 0;
    int? _connect = await platform
            ?.invokeMethod('startInternalPrinter', {'printerArgs': mapParam}) ??
        9999;
    if (_connect < 0) {
      throw ElginException(_connect);
    }
    return _connect;
  }

  ///*disconnect
  ///
  ///Disconnect the printer
  Future<int?> disconnect() async {
    int? _disconnect = await platform?.invokeMethod('stopPrinter') ?? 9999;
    if (_disconnect < 0) {
      throw ElginException(_disconnect);
    }

    return _disconnect;
  }

  ///*printXMLSAT
  ///
  ///Print a SAT XML with some parameters
  Future<int?> printSAT(String xml, {int param = 0}) async {
    Map<String, dynamic> mapParam = new Map();
    mapParam['xmlSAT'] = xml;
    mapParam['param'] = param;
    int? _printSAT =
        await platform?.invokeMethod("printSAT", {'satArgs': mapParam}) ?? 9999;
    if (_printSAT < 0) {
      throw ElginException(_printSAT);
    }
    return _printSAT;
  }

  ///*printXMLSAT
  ///
  ///Print a SAT XML with some parameters
  Future<int?> printNFCE(String xml, String csc, int cscId,
      {int param = 0}) async {
    Map<String, dynamic> mapParam = new Map();
    mapParam['xmlNFCe'] = xml;
    mapParam['indexcsc'] = cscId;
    mapParam['csc'] = csc;
    mapParam['param'] = param;
    int? _printNfce =
        await platform?.invokeMethod("printNFCE", {'nfceArgs': mapParam}) ??
            9999;
    if (_printNfce < 0) {
      throw ElginException(_printNfce);
    }
    return _printNfce;
  }

  ///*printTEF
  ///
  ///Print a SAT XML with some parameters
  Future<int?> printTEF(String cupomTEF) async {
    int? _printTEF =
        await platform?.invokeMethod("printTEF", {'cupomTEF': cupomTEF}) ??
            9999;
    if (_printTEF < 0) {
      throw ElginException(_printTEF);
    }
    return _printTEF;
  }

  ///*customCashier
  ///
  ///If you can open the cashiers that is not elgin, you can set the configurations and open
  Future<int> customCashier(int pin, int it, int dp) async {
    Map<String, dynamic> mapParam = new Map();
    mapParam['pin'] = pin;
    mapParam['it'] = it;
    mapParam['dp'] = dp;
    int? _customCash = await platform
            ?.invokeMethod("customCashier", {'cashierArgs': mapParam}) ??
        9999;

    if (_customCash < 0) {
      throw ElginException(_customCash);
    }
    return _customCash;
  }

  ///*cut
  ///
  ///Cut a line and jump N lines before
  Future<int> cut({int lines = 0}) async {
    int? _cut =
        await platform?.invokeMethod("cutPaper", {'lines': lines}) ?? 9999;

    if (_cut < 0) {
      throw ElginException(_cut);
    }
    return _cut;
  }

  ///*elginCashier
  ///
  ///If you have an elgin cashier, you can just open it with this!
  Future<int> elginCashier() async {
    int? _elginCash = await platform?.invokeMethod('elginCashier') ?? 9999;

    if (_elginCash < 0) {
      throw ElginException(_elginCash);
    }
    return _elginCash;
  }

  ///*feed
  ///
  ///Jump n lines
  Future<int> feed(int lines) async {
    int? _feed =
        await platform?.invokeMethod('feedLine', {'lines': lines}) ?? 9999;
    if (_feed < 0) {
      throw ElginException(_feed);
    }
    return _feed;
  }

  ///*libVersion
  ///
  ///Show the version that the software is using at this moment
  Future<String> get libVersion async =>
      await platform?.invokeMethod('libVersion');

  ///*line
  ///
  ///Just draw a simple line to divide some sectors in your print
  Future<void> line({String ch = '-', int len = 31}) async {
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
    int? _barcode = await platform
            ?.invokeMethod("printBarCode", {'barcodeArgs': mapParam}) ??
        9999;
    if (_barcode < 0) {
      throw ElginException(_barcode);
    }
    return _barcode;
  }

  ///*printImage
  ///
  ///You can print an image from web or from asset very easy with a [File]
  Future<int> printImage(File image, bool isBase64) async {
    await reset();
    Map<String, dynamic> mapParam = new Map();
    mapParam['path'] = image.path;
    mapParam['isBase64'] = isBase64;
    int? _image =
        await platform?.invokeMethod('printImage', {'imageArgs': mapParam}) ??
            9999;
    if (_image < 0) {
      throw ElginException(_image);
    }
    return _image;
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
    int? _qrcode =
        await platform?.invokeMethod("printQrcode", {'qrcodeArgs': mapParam}) ??
            9999;
    if (_qrcode < 0) {
      throw ElginException(_qrcode);
    }
    return _qrcode;
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
    int? _raw =
        await platform?.invokeMethod('printRaw', {'rawArgs': mapParam}) ?? 9999;

    if (_raw < 0) {
      throw ElginException(_raw);
    }
    return _raw;
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
    int? _print =
        await platform?.invokeMethod('printText', {"textArgs": mapParam}) ??
            9999;
    if (_print < 0) {
      throw ElginException(_print);
    }
    feed(1);
    return _print;
  }

  ///*reset
  ///
  ///This will just reset to the default status of the printer and will not clean any buffer
  Future<int> reset() async {
    int? _reset = await platform?.invokeMethod('reset') ?? 9999;

    if (_reset < 0) {
      throw ElginException(_reset);
    }
    return _reset;
  }

  ///*statusCashier
  ///
  ///Check if there is a chasier in the device or if it's working and everything else
  Future<int> statusCashier() async {
    int? _status = await platform?.invokeMethod('statusCashier') ?? 9999;
    if (_status < 0) {
      throw ElginException(_status);
    }
    return _status;
  }

  ///*statusEjetor
  ///
  ///Check the status of the ejector hardware
  Future<int> statusEjetor() async {
    int? _status = await platform?.invokeMethod('statusEjector') ?? 9999;
    if (_status < 0) {
      throw ElginException(_status);
    }
    return _status;
  }

  ///*statusSensor
  ///
  ///Check the status of the paper sensor hardware
  Future<int> statusSensor() async {
    int? _status = await platform?.invokeMethod('statusSensor') ?? 9999;

    if (_status < 0) {
      throw ElginException(_status);
    }
    return _status;
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
