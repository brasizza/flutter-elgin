/// Enumeração que define a posição do texto em relação ao código de barras impresso.
///
/// Use as constantes desta classe para determinar onde o texto será exibido
/// quando um código de barras for impresso na impressora Elgin.
///
/// Exemplo de uso:
/// ```dart
/// await Elgin.printer.printBarCode(
///   "1234567890",
///   textPosition: ElginBarcodeTextPosition.TEXT_ABOVE,
/// );
/// ```
class ElginBarcodeTextPosition {
  /// Valor inteiro utilizado pelo protocolo da impressora.
  final int value;

  /// Construtor privado para uso interno.
  const ElginBarcodeTextPosition._internal(this.value);

  /// Não exibe texto junto ao código de barras.
  static const NO_TEXT = ElginBarcodeTextPosition._internal(4);

  /// Exibe o texto acima do código de barras.
  static const TEXT_ABOVE = ElginBarcodeTextPosition._internal(1);

  /// Exibe o texto abaixo do código de barras.
  static const TEXT_UNDER = ElginBarcodeTextPosition._internal(2);

  /// Exibe o texto tanto acima quanto abaixo do código de barras.
  static const BOTH = ElginBarcodeTextPosition._internal(3);
}
