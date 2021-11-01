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
