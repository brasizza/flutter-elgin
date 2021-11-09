import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:elgin/components/elgin_size.dart';
import 'package:elgin/components/enums.dart';
import 'package:elgin/elgin.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Sunmi Printer',
        theme: ThemeData(
          primaryColor: Colors.black,
        ),
        debugShowCheckedModeBanner: false,
        home: const Home());
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool printBinded = false;
  String url = 'http://marcus.brasizza.com/imagens/flutter-icon.png';

  String printerVersion = "";
  @override
  void initState() {
    super.initState();
  }

  Future<int?> startPrinter(ElginPrinter driver) async {
    try {
      final int? result = await Elgin.printer.connect(driver: driver);

      setState(() {
        printBinded = result == 0 ? true : false;
      });
      if (result == 0) {
        String version = await Elgin.printer.libVersion;
        setState(() {
          printerVersion = version;
        });
      }
      return result;
    } on ElginException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.error.message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ELGIN printer Example'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
              ),
              child: Text("Print binded: " + printBinded.toString()),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              child: Text("Printer version: " + printerVersion),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () async {
                      final _driver = ElginPrinter(type: ElginPrinterType.MINIPDV);
                      await startPrinter(_driver);
                    },
                    child: const Text('Start M8/M10 printer')),
                ElevatedButton(
                    onPressed: () async {
                      final _driver = ElginPrinter(
                        type: ElginPrinterType.TCP,
                        model: ElginPrinterModel.GENERIC_TCP,
                        connection: '192.168.5.111',
                        parameter: 9100,
                      );
                      await startPrinter(_driver);
                    },
                    child: const Text('Start TCP/IP Printer (change IP in example)')),
                ElevatedButton(
                    onPressed: () async {
                      final _driver = ElginPrinter(
                        type: ElginPrinterType.USB,
                        model: ElginPrinterModel.MP2800,
                        connection: 'USB',
                        parameter: 115200,
                      );
                      await startPrinter(_driver);
                    },
                    child: const Text('USB PRINTER')),
                ElevatedButton(
                    onPressed: () async {
                      final _driver = ElginPrinter(
                        type: ElginPrinterType.BLUETHOOTH,
                        model: ElginPrinterModel.SMARTPOS,
                        connection: 'F4:5E:AB:D9:6C:3F',
                        parameter: 0,
                      );
                      await startPrinter(_driver);
                    },
                    child: const Text('BLUETOOTH PRINTER')),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        try {
                          await Elgin.printer.printQRCode(
                            "https://github.com/brasizza/flutter-elgin",
                            size: ElginQrcodeSize.SIZE5,
                            align: ElginAlign.CENTER,
                          );
                          await Elgin.printer.feed(2);
                        } on ElginException catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.error.message)));
                        }
                      },
                      child: const Text('Print qrCode')),
                  ElevatedButton(
                      onPressed: () async {
                        try {
                          await Elgin.printer.printBarCode(
                            '{C35170900246872000134590002121801051011580881',
                            barcodeType: EliginBarcodeType.CODE128,
                            textPosition: ElginBarcodeTextPosition.TEXT_UNDER,
                            align: ElginAlign.CENTER,
                            height: 100,
                            width: 3,
                          );
                          await Elgin.printer.feed(2);
                        } on ElginException catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.error.message)));
                        }
                      },
                      child: const Text('Print barCode')),
                  ElevatedButton(
                      onPressed: () async {
                        try {
                          await Elgin.printer.line();
                        } on ElginException catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.error.message)));
                        }
                      },
                      child: const Text('Print line')),
                  ElevatedButton(
                      onPressed: () async {
                        await Elgin.printer.feed(2);
                      },
                      child: const Text('Wrap line')),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        try {
                          await Elgin.printer.printString('Hello I\'m bold', isBold: true);
                        } on ElginException catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.error.message)));
                        }
                      },
                      child: const Text('Bold Text')),
                  ElevatedButton(
                      onPressed: () async {
                        try {
                          await Elgin.printer.printString('Normal font', fontSize: ElginSize.MD);
                          await Elgin.printer.feed(2);
                        } on ElginException catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.error.message)));
                        }
                      },
                      child: const Text('Normal font')),
                  ElevatedButton(
                      onPressed: () async {
                        try {
                          await Elgin.printer.printString('Large font', fontSize: ElginSize.LG);
                          await Elgin.printer.feed(2);
                        } on ElginException catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.error.message)));
                        }
                      },
                      child: const Text('Large font')),
                  ElevatedButton(
                      onPressed: () async {
                        try {
                          await Elgin.printer.printString('Very large font', fontSize: ElginSize.XL);
                          await Elgin.printer.feed(2);
                        } on ElginException catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.error.message)));
                        }
                      },
                      child: const Text('Very large font')),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        try {
                          await Elgin.printer.printString('Algin right', align: ElginAlign.RIGHT);
                          await Elgin.printer.feed(2);
                        } on ElginException catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.error.message)));
                        }
                      },
                      child: const Text('Align right')),
                  ElevatedButton(
                      onPressed: () async {
                        try {
                          await Elgin.printer.printString('Algin left', align: ElginAlign.RIGHT);
                          await Elgin.printer.feed(2);
                        } on ElginException catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.error.message)));
                        }
                      },
                      child: const Text('Align left')),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        await Elgin.printer.printString('Align center/ LARGE TEXT AND BOLD', align: ElginAlign.CENTER, isBold: true, fontSize: ElginSize.XL, isUnderline: true);
                        await Elgin.printer.feed(2);
                      } on ElginException catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.error.message)));
                      }
                    },
                    child: const Text('Align center'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () async {
                      Uint8List byte = await _getImageFromAsset('assets/images/dash.jpeg');
                      Directory tempPath = await getTemporaryDirectory();
                      File file = File('${tempPath.path}/dash.jpg');
                      await file.writeAsBytes(byte.buffer.asUint8List(byte.offsetInBytes, byte.lengthInBytes));
                      try {
                        await Elgin.printer.printImage(file, false);
                      } on ElginException catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.error.message)));
                      }
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/dash.jpeg',
                          width: 100,
                        ),
                        const Text('Print this image from asset!')
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      // convert image to Uint8List format
                      Uint8List byte = (await NetworkAssetBundle(Uri.parse(url)).load(url)).buffer.asUint8List();
                      Directory tempPath = await getTemporaryDirectory();
                      File file = File('${tempPath.path}/onlineImage.jpg');
                      await file.writeAsBytes(byte.buffer.asUint8List(byte.offsetInBytes, byte.lengthInBytes));
                      try {
                        await Elgin.printer.printImage(file, false);
                      } on ElginException catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.error.message)));
                      }
                    },
                    child: Column(
                      children: [
                        Image.network(
                          url,
                          width: 100,
                        ),
                        const Text('Print this image from WEB!')
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                    ElevatedButton(
                        onPressed: () async {
                          try {
                            await Elgin.printer.cut();
                          } on ElginException catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.error.message)));
                          }
                        },
                        child: const Text('CUT PAPER')),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                    ElevatedButton(
                        onPressed: () async {
                          try {
                            final List<int> _escPos = await _customEscPos();
                            await Elgin.printer.printRaw(_escPos);
                          } on ElginException catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.error.message)));
                          }
                        },
                        child: const Text('Custom ESC/POS to print')),
                  ]),
                ),
              ],
            ),
            const Divider(),
            Text("Sensors"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                    ElevatedButton(
                        onPressed: () async {
                          try {
                            int _sensor = await Elgin.printer.statusSensor();
                            String messageSensor = 'Sensor is OK';
                            if (_sensor == 6) {
                              messageSensor = 'Paper is running out!';
                            }
                            if (_sensor == 7) {
                              messageSensor = 'No paper!';
                            }
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(messageSensor)));
                          } on ElginException catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.error.message)));
                          }
                        },
                        child: const Text('Paper sensor')),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                    ElevatedButton(
                        onPressed: () async {
                          try {
                            await Elgin.printer.elginCashier();
                          } on ElginException catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.error.message)));
                          }
                        },
                        child: const Text('Elgin cashier')),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                    ElevatedButton(
                        onPressed: () async {
                          try {
                            await Elgin.printer.customCashier(1, 2, 3);
                          } on ElginException catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.error.message)));
                          }
                        },
                        child: const Text('Custom cashier')),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                    ElevatedButton(
                        onPressed: () async {
                          try {
                            await Elgin.printer.beep(5, 10, 20);
                          } on ElginException catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.error.message)));
                          }
                        },
                        child: const Text('Beep')),
                  ]),
                ),
              ],
            ),
            const Divider(),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                    ElevatedButton(
                        onPressed: () async {
                          String xmlSAT =
                              '<?xml version="1.0"?><CFe><infCFe versaoDadosEnt="0.07"><ide><CNPJ>08427847000169</CNPJ><signAC>SGR-SAT SISTEMA DE GESTAO E RETAGUARDA DO SAT</signAC><numeroCaixa>001</numeroCaixa></ide><emit><CNPJ>61099008000141</CNPJ><IE>111111111111</IE><IM>12345</IM><cRegTribISSQN>3</cRegTribISSQN><indRatISSQN>N</indRatISSQN></emit><dest/><det nItem="1"><prod><cProd>116</cProd><cEAN>9990000001163</cEAN><xProd>Cascao</xProd><CFOP>5405</CFOP><uCom>UN</uCom><qCom>1.0000</qCom><vUnCom>4.00</vUnCom><indRegra>A</indRegra></prod><imposto><ICMS><ICMSSN102><Orig>0</Orig><CSOSN>500</CSOSN></ICMSSN102></ICMS><PIS><PISSN><CST>49</CST></PISSN></PIS><COFINS><COFINSSN><CST>49</CST></COFINSSN></COFINS></imposto></det><total/><pgto><MP><cMP>01</cMP><vMP>4.00</vMP></MP></pgto></infCFe></CFe>';
                          try {
                            await Elgin.printer.printSAT(xmlSAT);
                          } on ElginException catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.error.message)));
                          }
                        },
                        child: const Text('PRINT SAT XML')),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                    ElevatedButton(
                        onPressed: () async {
                          String csc = '';
                          int cscId = 0;
                          String xmlNFCE = 'XML NFCE';
                          try {
                            await Elgin.printer.printNFCE(xmlNFCE, csc, cscId, param: 4);
                          } on ElginException catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.error.message)));
                          }
                        },
                        child: const Text('PRINT NFCE XML')),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                    ElevatedButton(
                        onPressed: () async {
                          String cupomTef = 'ICAgICAgICAgICAgICAgICBSRURFCiAgICAgICAgIE1BU1RFUkNBUkQgREVCSVRPICAgICAgICAgTApDT01QUk9WOiAxMjM0NTY3ODk5IFZBTE9SOiAgICAgICAgNDQsMDcKRVNUQUI6MTIzMzMzMyBFU1RBQkVMRUNJTUVOVE8gVEVTVEUgTFREQQpDTlBKL0NQRjoxMS4xMTEuMTExLzAwMDEtMTEKMDcuMTEuMjEtMjI6MTM6MDIgVEVSTTpQVjYzOTczMi8wMDAyNTMKQ0FSVEFPOiB4eHh4eHh4eHh4eHg5OTk5CkFVVE9SSVpBQ0FPOiAzMjE2NzcKQVJRQzpCRjZGM0IxN0RENTFDRDBBCkFJRDogQTAwMDAwMDAwNDQ0NDQ0CiAgICBUUkFOU0FDQU8gQVBST1ZBREEgUEVMTyBFTUlTU09SCgoKCgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKFNpVGVmKQo=';
                          try {
                            await Elgin.printer.printTEF(utf8.decode(base64.decode(cupomTef)));
                          } on ElginException catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.error.message)));
                          }
                        },
                        child: const Text('PRINT TEF BASE64')),
                  ]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Future<Uint8List> readFileBytes(String path) async {
  ByteData fileData = await rootBundle.load(path);
  Uint8List fileUnit8List = fileData.buffer.asUint8List(fileData.offsetInBytes, fileData.lengthInBytes);
  return fileUnit8List;
}

Future<Uint8List> _getImageFromAsset(String iconPath) async {
  return await readFileBytes(iconPath);
}

Future<List<int>> _customEscPos() async {
  final profile = await CapabilityProfile.load();
  final generator = Generator(PaperSize.mm58, profile);
  List<int> bytes = [];

  bytes += generator.text('Regular: aA bB cC dD eE fF gG hH iI jJ kK lL mM nN oO pP qQ rR sS tT uU vV wW xX yY zZ');
  bytes += generator.text('Bold text', styles: const PosStyles(bold: true));
  bytes += generator.text('Reverse text', styles: const PosStyles(reverse: true));
  bytes += generator.text('Underlined text', styles: const PosStyles(underline: true), linesAfter: 1);
  bytes += generator.text('Align left', styles: const PosStyles(align: PosAlign.left));
  bytes += generator.text('Align center', styles: const PosStyles(align: PosAlign.center));
  bytes += generator.text('Align right', styles: const PosStyles(align: PosAlign.right), linesAfter: 1);
  bytes += generator.qrcode('Barcode by escpos', size: QRSize.Size4, cor: QRCorrection.H);
  bytes += generator.feed(2);

  bytes += generator.row([
    PosColumn(
      text: 'col3',
      width: 3,
      styles: const PosStyles(align: PosAlign.center, underline: true),
    ),
    PosColumn(
      text: 'col6',
      width: 6,
      styles: const PosStyles(align: PosAlign.center, underline: true),
    ),
    PosColumn(
      text: 'col3',
      width: 3,
      styles: const PosStyles(align: PosAlign.center, underline: true),
    ),
  ]);

  bytes += generator.text('Text size 200%',
      styles: const PosStyles(
        height: PosTextSize.size2,
        width: PosTextSize.size2,
      ));

  bytes += generator.reset();

  return bytes;
}
