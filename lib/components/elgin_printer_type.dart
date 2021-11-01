///*ElginPrinterType
///
///Types of the printers that the package can connect!
class ElginPrinterType {
  const ElginPrinterType._internal(this.value);
  final int value;
  static const USB = ElginPrinterType._internal(1);
  static const SERIAL = ElginPrinterType._internal(2);
  static const TCP = ElginPrinterType._internal(3);
  static const BLUETHOOTH = ElginPrinterType._internal(4);
  static const SMARTPOS = ElginPrinterType._internal(5);
  static const MINIPDV = ElginPrinterType._internal(6);
}
