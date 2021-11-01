///*ElginPrinterModel
///
///Printers model
class ElginPrinterModel {
  const ElginPrinterModel._internal(this.value);
  final String value;

  static const I7 = ElginPrinterModel._internal("I7");
  static const I8 = ElginPrinterModel._internal("I8");
  static const I9 = ElginPrinterModel._internal("I9");
  static const IX = ElginPrinterModel._internal("IX");
  static const FITPOS = ElginPrinterModel._internal("Fitpos");
  static const BKT681 = ElginPrinterModel._internal("BK-T681");
  static const MP4200 = ElginPrinterModel._internal("MP-4200");
  static const MP2800 = ElginPrinterModel._internal("MP-2800");
  static const DR800 = ElginPrinterModel._internal("DR800");
  static const GENERIC_TCP = ElginPrinterModel._internal("I9");
  static const IDTOUCH = ElginPrinterModel._internal("Print ID Touch");
  static const SMARTPOS = ElginPrinterModel._internal("SmartPOS");
  static const MINIPDV = ElginPrinterModel._internal("M8");
}
