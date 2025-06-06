/// Enumeração dos níveis de correção de erro para impressão de QR Code.
///
/// Estes níveis determinam o percentual de dados que podem ser recuperados
/// caso o QR Code seja danificado ou parcialmente ilegível.
/// Use as constantes desta classe ao imprimir QR Codes em impressoras Elgin.
///
/// Exemplo de uso:
/// ```dart
/// await Elgin.printer.printQRCode(
///   "https://exemplo.com",
///   correction: ElginQrcodeCorrection.LEVEL_H,
/// );
/// ```
class ElginQrcodeCorrection {
  /// Valor inteiro utilizado pelo protocolo da impressora para o nível de correção.
  final int value;

  /// Construtor privado para uso interno.
  const ElginQrcodeCorrection._internal(this.value);

  /// Correção de nível L (Low) – recupera até 7% dos dados.
  static const LEVEL_L = ElginQrcodeCorrection._internal(1);

  /// Correção de nível M (Medium) – recupera até 15% dos dados.
  static const LEVEL_M = ElginQrcodeCorrection._internal(2);

  /// Correção de nível Q (Quartile) – recupera até 25% dos dados.
  static const LEVEL_Q = ElginQrcodeCorrection._internal(3);

  /// Correção de nível H (High) – recupera até 30% dos dados.
  static const LEVEL_H = ElginQrcodeCorrection._internal(4);
}
