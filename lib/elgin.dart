import 'dart:async';

import 'package:elgin/services/printer.dart';
import 'package:flutter/services.dart';
export 'package:elgin/components/enums.dart';

final platform = const MethodChannel('elgin');

class Elgin {
  static Printer get printer => Printer.instance(platform);

  static Future<String?> get platformVersion async => await platform.invokeMethod('getPlatformVersion');
}
