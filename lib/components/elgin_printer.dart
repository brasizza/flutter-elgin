import 'package:elgin/components/elgin_printer_model.dart';
import 'package:elgin/components/elgin_printer_type.dart';

///*ElginPrinter
///
///Setting the printer driver to the connection with [type] and [model]!

class ElginPrinter {
  final ElginPrinterType type;
  final ElginPrinterModel? model;
  String? connection;
  int? parameter;
  ElginPrinter({
    required this.type,
    this.model,
    this.connection,
    this.parameter,
  });
}
