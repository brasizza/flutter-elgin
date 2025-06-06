/// Enumeração de estilos de fonte disponíveis para impressão.
///
/// Use as constantes desta classe para alterar o tipo ou o estilo da fonte
/// ao imprimir textos em dispositivos Elgin.
///
/// Exemplo de uso:
/// ```dart
/// await Elgin.printer.printString(
///   "Texto em negrito",
///   font: ElginFont.BOLD,
/// );
/// ```
class ElginFont {
  /// Valor inteiro do estilo de fonte utilizado pelo protocolo da impressora.
  final int value;

  /// Construtor privado para uso interno.
  const ElginFont._internal(this.value);

  /// Fonte padrão A.
  static const FONTA = ElginFont._internal(0);

  /// Fonte padrão B.
  static const FONTB = ElginFont._internal(1);

  /// Estilo sublinhado.
  static const UNDERLINE = ElginFont._internal(2);

  /// Estilo negrito (bold).
  static const BOLD = ElginFont._internal(8);

  /// Estilo reverso (inverte as cores da impressão).
  static const REVERSE = ElginFont._internal(4);
}
