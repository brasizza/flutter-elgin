///*EliginBarcodeType
///
///All the barcode types to print any barcode
class EliginBarcodeType {
  const EliginBarcodeType._internal(this.value);
  final int value;
  static const UPCA = EliginBarcodeType._internal(0);
  static const UPCE = EliginBarcodeType._internal(1);
  static const JAN13 = EliginBarcodeType._internal(2);
  static const JAN8 = EliginBarcodeType._internal(3);
  static const CODE39 = EliginBarcodeType._internal(4);
  static const ITF = EliginBarcodeType._internal(5);
  static const CODEBAR = EliginBarcodeType._internal(6);
  static const CODE93 = EliginBarcodeType._internal(7);
  static const CODE128 = EliginBarcodeType._internal(8);
}
