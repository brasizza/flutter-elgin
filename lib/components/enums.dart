///*ElginAlign
///
///Class to set the alignment to the objects in the paper
class ElginAlign {
  const ElginAlign._internal(this.value);
  final int value;
  static const LEFT = ElginAlign._internal(0);
  static const CENTER = ElginAlign._internal(1);
  static const RIGHT = ElginAlign._internal(2);
}

///*ElginSize
///
///Class to set the size to text in the paper
class ElginSize {
  const ElginSize._internal(this.value);
  final int value;
  static const MD = ElginSize._internal(0);
  static const LG = ElginSize._internal(16);
  static const XL = ElginSize._internal(24);
}

///*ElginFont
///
///Change the font
class ElginFont {
  const ElginFont._internal(this.value);
  final int value;
  static const FONTA = ElginFont._internal(0);
  static const FONTB = ElginFont._internal(1);
  static const UNDERLINE = ElginFont._internal(2);
  static const BOLD = ElginFont._internal(8);
  static const REVERSE = ElginFont._internal(4);
}

///*ElginQrcodeSize
///
///Change the size of the qrcode between 1 and 6
class ElginQrcodeSize {
  const ElginQrcodeSize._internal(this.value);
  final int value;
  static const SIZE1 = ElginQrcodeSize._internal(1);
  static const SIZE2 = ElginQrcodeSize._internal(2);
  static const SIZE3 = ElginQrcodeSize._internal(3);
  static const SIZE4 = ElginQrcodeSize._internal(4);
  static const SIZE5 = ElginQrcodeSize._internal(5);
  static const SIZE6 = ElginQrcodeSize._internal(6);
}

///*ElginQrcodeCorrection
///
///Qrcode correction between low and high
class ElginQrcodeCorrection {
  const ElginQrcodeCorrection._internal(this.value);
  final int value;
  static const LEVEL_L = ElginQrcodeCorrection._internal(1);
  static const LEVEL_M = ElginQrcodeCorrection._internal(2);
  static const LEVEL_Q = ElginQrcodeCorrection._internal(3);
  static const LEVEL_H = ElginQrcodeCorrection._internal(4);
}

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
