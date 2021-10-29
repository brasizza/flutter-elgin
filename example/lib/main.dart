import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:elgin/elgin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  int _printerConnected = 0;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    int printer = 0;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await Elgin.platformVersion ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    Elgin.printer.connect().then((value) async {
      printer = value!;

      await Elgin.printer.printString(
        "TESTEEEEE",
      );
      await Elgin.printer.printString(
        "TESTEEEEE",
        fontSize: ElginSize.LG,
      );
      await Elgin.printer.printString("TESTEEEEE", fontSize: ElginSize.MD, font: ElginFont.REVERSE);
      await Elgin.printer.printString(
        "TESTEEEEE",
      );
      await Elgin.printer.printString(
        "TESTEEEEE",
      );
      await Elgin.printer.printString(
        "TESTEEEEE",
      );
      await Elgin.printer.printString(
        "TESTEEEEE",
      );
      await Elgin.printer.printString(
        "TESTEEEEE",
      );

      await Elgin.printer.feed(2);
      await Elgin.printer.printQrcode("MARCUS BRASIZZA");

      await Elgin.printer.cut(7);
    });

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
      _printerConnected = printer;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            Center(
              child: Text('Running on: $_platformVersion\n'),
            ),
            Center(
              child: Text('Printer status: $_printerConnected\n'),
            ),
          ],
        ),
      ),
    );
  }
}
