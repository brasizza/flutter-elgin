/// Enumeração dos tamanhos de texto disponíveis para impressão.
///
/// Utilize estas constantes para definir o tamanho do texto na impressão.
/// Também é possível criar um tamanho personalizado usando o método [customFont].
///
/// Exemplo de uso:
/// ```dart
/// await Elgin.printer.printString(
///   "Texto grande",
///   fontSize: ElginSize.LG,
/// );
///
/// // Para tamanho personalizado:
/// final custom = ElginSize.customFont(fontSize: 32);
/// await Elgin.printer.printString(
///   "Texto personalizado",
///   fontSize: custom,
/// );
/// ```
class ElginSize {
  /// Valor inteiro utilizado pelo protocolo da impressora para o tamanho do texto.
  final int value;

  /// Construtor privado para uso interno.
  const ElginSize._internal(this.value);

  /// Tamanho médio padrão (default).
  static const MD = ElginSize._internal(0);

  /// Tamanho grande.
  static const LG = ElginSize._internal(16);

  /// Tamanho extra grande.
  static const XL = ElginSize._internal(24);

  /// Cria um tamanho de fonte personalizado.
  ///
  /// [fontSize] Valor inteiro representando o tamanho da fonte.
  /// Útil para ajustes específicos conforme a necessidade do layout.
  static ElginSize customFont({required int fontSize}) {
    return ElginSize._internal(fontSize);
  }
}
