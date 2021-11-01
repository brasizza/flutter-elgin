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
