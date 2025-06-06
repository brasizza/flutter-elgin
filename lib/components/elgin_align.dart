/// Enumeração de alinhamento para objetos impressos no papel.
///
/// Use as constantes desta classe para definir o alinhamento de textos,
/// códigos de barras, QR Codes e outros elementos ao imprimir com dispositivos Elgin.
///
/// Exemplo de uso:
/// ```dart
/// await Elgin.printer.printString(
///   "Texto centralizado",
///   align: ElginAlign.CENTER,
/// );
/// ```
class ElginAlign {
  /// Valor inteiro do alinhamento utilizado pelo protocolo nativo.
  final int value;

  /// Construtor privado para uso interno.
  const ElginAlign._internal(this.value);

  /// Alinhamento à esquerda.
  static const LEFT = ElginAlign._internal(0);

  /// Alinhamento centralizado.
  static const CENTER = ElginAlign._internal(1);

  /// Alinhamento à direita.
  static const RIGHT = ElginAlign._internal(2);
}
