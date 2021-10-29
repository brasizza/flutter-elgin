import 'dart:io';
import 'dart:typed_data';

import 'package:elgin/components/enums.dart';
import 'package:elgin/elgin.dart';
import 'package:flutter/services.dart';

class Printer {
  Printer._();
  static MethodChannel? platform;
  static Printer? _instance;
  static Printer instance(MethodChannel methodChannel) {
    platform = methodChannel;

    _instance ??= Printer._();
    return _instance!;
  }

  Future<void> line({
    String ch = '-',
    int len = 31,
  }) async {
    await printString(List.filled(len, ch[0]).join());
  }

  Future<int> printString(
    String text, {
    ElginAlign align = ElginAlign.LEFT,
    bool isBold = false,
    bool isUnderline = false,
    ElginFont font = ElginFont.FONTA,
    ElginSize fontSize = ElginSize.MD,
  }) async {
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

  Future<int> printBarCode(String text, {EliginBarcodeType barcodeType = EliginBarcodeType.JAN8, ElginAlign align = ElginAlign.RIGHT, int height = 50, int width = 6, ElginBarcodeTextPosition textPosition = ElginBarcodeTextPosition.NO_TEXT}) async {
    Map<String, dynamic> mapParam = new Map();
    mapParam['barCodeType'] = barcodeType.value;
    mapParam['text'] = text;
    mapParam['height'] = height;
    mapParam['align'] = align.value;
    mapParam['width'] = width;
    mapParam['textPosition'] = textPosition.value;
    return await platform?.invokeMethod("printBarCode", {'barcodeArgs': mapParam});
  }

  Future<int> printQRCode(
    String text, {
    ElginQrcodeSize size = ElginQrcodeSize.SIZE4,
    ElginAlign align = ElginAlign.CENTER,
    ElginQrcodeCorrection correction = ElginQrcodeCorrection.LEVEL_M,
  }) async {
    Map<String, dynamic> mapParam = new Map();
    mapParam['size'] = size.value;
    mapParam['align'] = align.value;
    mapParam['correction'] = correction.value;
    mapParam['text'] = text;
    return await platform?.invokeMethod("printQrcode", {'qrcodeArgs': mapParam});
  }

  Future<int> printImage(File image, bool isBase64) async {
    Map<String, dynamic> mapParam = new Map();

    mapParam['path'] = image.path;
    mapParam['isBase64'] = isBase64;
    return await platform?.invokeMethod('printImage', {'imageArgs': mapParam});
  }

  Future<int> printRaw(List<int> rawList) async {
    Map<String, dynamic> mapParam = new Map();
    Uint8List _list = Uint8List.fromList(rawList);
    mapParam['data'] = _list;
    mapParam['bytes'] = _list.lengthInBytes;
    return await platform?.invokeMethod('printRaw', {'rawArgs': mapParam});
  }

  // Future<int> sendPrinterNFCe(String xmlNFCe, int indexcsc, String csc, int param) async {
  //   Map<String, dynamic> mapParam = new Map();
  //   mapParam['xmlNFCe'] = xmlNFCe;
  //   mapParam['indexcsc'] = indexcsc;
  //   mapParam['csc'] = csc;
  //   mapParam['param'] = param;
  //   mapParam['typePrinter'] = "printerNFCe";
  //   return await _sendFunctionToAndroid(mapParam);
  // }

  // Future<int> sendPrinterSAT(String xmlSAT, int param) async {
  //   Map<String, dynamic> mapParam = new Map();
  //   mapParam['xmlSAT'] = xmlSAT;
  //   mapParam['param'] = param;
  //   mapParam['typePrinter'] = "printerSAT";
  //   return await _sendFunctionToAndroid(mapParam);
  // }

  // Future<String> getStatusPrinter() async {
  //   Map<String, dynamic> mapParam = new Map();

  //   mapParam['typePrinter'] = "printerStatus";

  //   int codeReturn = await _sendFunctionToAndroid(mapParam);

  //   if (codeReturn == 5)
  //     return "papel está presente e não está próximo do fim!";
  //   else if (codeReturn == 6)
  //     return "Papel próximo do fim!";
  //   else if (codeReturn == 7)
  //     return "Papel ausente!";
  //   else
  //     return "Status Desconhecido!";
  // }

  Future<int?> connect() async {
    final int? status = await platform?.invokeMethod('startInternalPrinter') ?? 0;
    return status;
  }

  Future<int?> disconnect() async {
    final int? status = await platform?.invokeMethod('printerStop') ?? 0;
    return status;
  }

  Future<int> cut({int lines = 0}) async {
    return await platform?.invokeMethod("cutPaper", {'lines': lines});
  }

  Future<int> feed(int lines) async {
    return await platform?.invokeMethod('feedLine', {'lines': lines});
  }
}
