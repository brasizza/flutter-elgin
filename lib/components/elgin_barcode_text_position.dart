///*ElginBarcodeTextPosition
///
///Where in the barcode the text will be show
class ElginBarcodeTextPosition {
  const ElginBarcodeTextPosition._internal(this.value);
  final int value;
  static const NO_TEXT = ElginBarcodeTextPosition._internal(4);
  static const TEXT_ABOVE = ElginBarcodeTextPosition._internal(1);
  static const TEXT_UNDER = ElginBarcodeTextPosition._internal(2);
  static const BOTH = ElginBarcodeTextPosition._internal(3);
}
