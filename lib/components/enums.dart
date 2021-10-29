class ElginAlign {
  const ElginAlign._internal(this.value);
  final int value;
  static const LEFT = ElginAlign._internal(0);
  static const CENTER = ElginAlign._internal(1);
  static const RIGHT = ElginAlign._internal(2);
}

class ElginSize {
  const ElginSize._internal(this.value);
  final int value;
  static const MD = ElginSize._internal(0);
  static const LG = ElginSize._internal(24);
  static const XL = ElginSize._internal(36);
}

class ElginFont {
  const ElginFont._internal(this.value);
  final int value;
  static const FONTA = ElginFont._internal(0);
  static const FONTB = ElginFont._internal(1);
  static const UNDERLINE = ElginFont._internal(2);
  static const BOLD = ElginFont._internal(8);
  static const REVERSE = ElginFont._internal(4);
}

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

class ElginQrcodeCorrection {
  const ElginQrcodeCorrection._internal(this.value);
  final int value;
  static const LEVEL_L = ElginQrcodeCorrection._internal(1);
  static const LEVEL_M = ElginQrcodeCorrection._internal(2);
  static const LEVEL_Q = ElginQrcodeCorrection._internal(3);
  static const LEVEL_H = ElginQrcodeCorrection._internal(4);
}
