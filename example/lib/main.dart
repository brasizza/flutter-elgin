import 'package:elgin_example/pages/printer_page.dart';
import 'package:elgin_example/pages/sat_page.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(
                  child: Text('Printer'),
                ),
                Tab(child: Text('SAT')),
              ],
            ),
            title: const Text('ELGIN printer Example'),
          ),
          body: TabBarView(
            children: [
              PrinterPage(),
              SatPage(),
            ],
          )),
    );
  }
}
