/// Enumeração dos tamanhos disponíveis para impressão de QR Code.
///
/// Use estas constantes para definir o tamanho do QR Code ao imprimir
/// em uma impressora Elgin. O valor deve variar de 1 (menor) a 6 (maior),
/// sendo que tamanhos maiores facilitam a leitura em distâncias maiores.
///
/// Exemplo de uso:
/// ```dart
/// await Elgin.printer.printQRCode(
///   "https://exemplo.com",
///   size: ElginQrcodeSize.SIZE4,
/// );
/// ```
class ElginQrcodeSize {
  /// Valor inteiro utilizado pelo protocolo da impressora para o tamanho.
  final int value;

  /// Construtor privado para uso interno.
  const ElginQrcodeSize._internal(this.value);

  /// Tamanho 1 (menor QR Code).
  static const SIZE1 = ElginQrcodeSize._internal(1);

  /// Tamanho 2.
  static const SIZE2 = ElginQrcodeSize._internal(2);

  /// Tamanho 3.
  static const SIZE3 = ElginQrcodeSize._internal(3);

  /// Tamanho 4 (recomendado para uso geral).
  static const SIZE4 = ElginQrcodeSize._internal(4);

  /// Tamanho 5.
  static const SIZE5 = ElginQrcodeSize._internal(5);

  /// Tamanho 6 (maior QR Code possível).
  static const SIZE6 = ElginQrcodeSize._internal(6);
}
