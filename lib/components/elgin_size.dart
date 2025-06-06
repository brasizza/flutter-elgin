///*ElginSize
///
///Class to set the size to text in the paper
library;
// ignore_for_file: constant_identifier_names

class ElginSize {
  const ElginSize._internal(this.value);
  final int value;
  static const MD = ElginSize._internal(0);
  static const LG = ElginSize._internal(16);
  static const XL = ElginSize._internal(24);
  static void customFont({required int fontSize}) {
    ElginSize._internal(fontSize);
  }
}
