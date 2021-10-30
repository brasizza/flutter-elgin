import 'dart:async';

import 'package:elgin/services/printer.dart';
import 'package:flutter/services.dart';
export 'package:elgin/components/enums.dart';

///*platform
///
///channel between dart and android
final platform = const MethodChannel('elgin');

///*Elgin
///
///This class will all the possible istances to all te devices that i will implement in the future
class Elgin {
  ///*printer
  ///
  ///Printer instance to do all the things with printer
  static Printer get printer => Printer.instance(platform);

  ///*platformVersion
  ///
  ///Just a method to get the android version
  static Future<String?> get platformVersion async =>
      await platform.invokeMethod('getPlatformVersion');
}
