import 'dart:io';
import 'dart:typed_data';
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

    _bindingPrinter().then((int? isBind) async {
      Elgin.printer.libVersion.then((String version) {
        setState(() {
          printerVersion = version;
        });
      });

      setState(() {
        printBinded = isBind == 0 ? true : false;
      });
    });
  }

  /// must binding ur printer at first init in app
  Future<int?> _bindingPrinter() async {
    final int? result = await Elgin.printer.connect();
    return result;
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        await Elgin.printer.printQRCode(
                          "https://github.com/brasizza/flutter-elgin",
                          size: ElginQrcodeSize.SIZE5,
                          align: ElginAlign.CENTER,
                        );
                        await Elgin.printer.feed(2);
                      },
                      child: const Text('Print qrCode')),
                  ElevatedButton(
                      onPressed: () async {
                        await Elgin.printer.printBarCode(
                          '{C35170900246872000134590002121801051011580881',
                          barcodeType: EliginBarcodeType.CODE128,
                          textPosition: ElginBarcodeTextPosition.TEXT_UNDER,
                          align: ElginAlign.CENTER,
                          height: 100,
                          width: 3,
                        );
                        await Elgin.printer.feed(2);
                      },
                      child: const Text('Print barCode')),
                  ElevatedButton(
                      onPressed: () async {
                        await Elgin.printer.line();
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
                        await Elgin.printer
                            .printString('Hello I\'m bold', isBold: true);
                      },
                      child: const Text('Bold Text')),
                  ElevatedButton(
                      onPressed: () async {
                        await Elgin.printer
                            .printString('Normal font', fontSize: ElginSize.MD);
                        await Elgin.printer.feed(2);
                      },
                      child: const Text('Normal font')),
                  ElevatedButton(
                      onPressed: () async {
                        await Elgin.printer
                            .printString('Large font', fontSize: ElginSize.LG);
                        await Elgin.printer.feed(2);
                      },
                      child: const Text('Large font')),
                  ElevatedButton(
                      onPressed: () async {
                        await Elgin.printer.printString('Very large font',
                            fontSize: ElginSize.XL);
                        await Elgin.printer.feed(2);
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
                        await Elgin.printer.printString('Algin right',
                            align: ElginAlign.RIGHT);
                        await Elgin.printer.feed(2);
                      },
                      child: const Text('Align right')),
                  ElevatedButton(
                      onPressed: () async {
                        await Elgin.printer
                            .printString('Algin left', align: ElginAlign.RIGHT);
                        await Elgin.printer.feed(2);
                      },
                      child: const Text('Align left')),
                  ElevatedButton(
                    onPressed: () async {
                      await Elgin.printer.printString(
                          'Align center/ LARGE TEXT AND BOLD',
                          align: ElginAlign.CENTER,
                          isBold: true,
                          fontSize: ElginSize.XL,
                          isUnderline: true);
                      await Elgin.printer.feed(2);
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
                      Uint8List byte =
                          await _getImageFromAsset('assets/images/dash.jpeg');
                      Directory tempPath = await getTemporaryDirectory();
                      File file = File('${tempPath.path}/dash.jpg');
                      await file.writeAsBytes(byte.buffer
                          .asUint8List(byte.offsetInBytes, byte.lengthInBytes));
                      await Elgin.printer.printImage(file, false);
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
                      Uint8List byte =
                          (await NetworkAssetBundle(Uri.parse(url)).load(url))
                              .buffer
                              .asUint8List();
                      Directory tempPath = await getTemporaryDirectory();
                      File file = File('${tempPath.path}/onlineImage.jpg');
                      await file.writeAsBytes(byte.buffer
                          .asUint8List(byte.offsetInBytes, byte.lengthInBytes));
                      await Elgin.printer.printImage(file, false);
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
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                            onPressed: () async {
                              await Elgin.printer.cut();
                            },
                            child: const Text('CUT PAPER')),
                      ]),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                            onPressed: () async {
                              final List<int> _escPos = await _customEscPos();
                              await Elgin.printer.printRaw(_escPos);
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
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                            onPressed: () async {
                              int _sensor = await Elgin.printer.statusSensor();
                              String messageSensor = 'Sensor is OK';
                              if (_sensor == 6) {
                                messageSensor = 'Paper is running out!';
                              }
                              if (_sensor == 7) {
                                messageSensor = 'No paper!';
                              }
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(messageSensor)));
                            },
                            child: const Text('Paper sensor')),
                      ]),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                            onPressed: () async {
                              await Elgin.printer.elginCashier();
                            },
                            child: const Text('Elgin cashier')),
                      ]),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                            onPressed: () async {
                              await Elgin.printer.customCashier(1, 2, 3);
                            },
                            child: const Text('Custom cashier')),
                      ]),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                            onPressed: () async {
                              await Elgin.printer.beep(5, 10, 20);
                            },
                            child: const Text('Beep')),
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
  Uint8List fileUnit8List = fileData.buffer
      .asUint8List(fileData.offsetInBytes, fileData.lengthInBytes);
  return fileUnit8List;
}

Future<Uint8List> _getImageFromAsset(String iconPath) async {
  return await readFileBytes(iconPath);
}

Future<List<int>> _customEscPos() async {
  final profile = await CapabilityProfile.load();
  final generator = Generator(PaperSize.mm58, profile);
  List<int> bytes = [];

  bytes += generator.text(
      'Regular: aA bB cC dD eE fF gG hH iI jJ kK lL mM nN oO pP qQ rR sS tT uU vV wW xX yY zZ');
  bytes += generator.text('Bold text', styles: const PosStyles(bold: true));
  bytes +=
      generator.text('Reverse text', styles: const PosStyles(reverse: true));
  bytes += generator.text('Underlined text',
      styles: const PosStyles(underline: true), linesAfter: 1);
  bytes += generator.text('Align left',
      styles: const PosStyles(align: PosAlign.left));
  bytes += generator.text('Align center',
      styles: const PosStyles(align: PosAlign.center));
  bytes += generator.text('Align right',
      styles: const PosStyles(align: PosAlign.right), linesAfter: 1);
  bytes += generator.qrcode('Barcode by escpos',
      size: QRSize.Size4, cor: QRCorrection.H);
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
  bytes += generator.cut();

  return bytes;
}
