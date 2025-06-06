///*ElginAlign
///
///Class to set the alignment to the objects in the paper
library;
// ignore_for_file: constant_identifier_names

class ElginAlign {
  const ElginAlign._internal(this.value);
  final int value;
  static const LEFT = ElginAlign._internal(0);
  static const CENTER = ElginAlign._internal(1);
  static const RIGHT = ElginAlign._internal(2);
}
