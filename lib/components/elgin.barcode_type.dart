/// Enumeração dos tipos de código de barras suportados para impressão.
///
/// Utilize estas constantes para definir o formato do código de barras
/// ao imprimir com as impressoras Elgin.
///
/// Exemplo de uso:
/// ```dart
/// await Elgin.printer.printBarCode(
///   "1234567890",
///   barcodeType: EliginBarcodeType.CODE128,
/// );
/// ```
class EliginBarcodeType {
  /// Valor inteiro utilizado pelo protocolo da impressora para identificar o tipo de código de barras.
  final int value;

  /// Construtor privado para uso interno.
  const EliginBarcodeType._internal(this.value);

  /// Código de barras no formato UPC-A.
  static const UPCA = EliginBarcodeType._internal(0);

  /// Código de barras no formato UPC-E.
  static const UPCE = EliginBarcodeType._internal(1);

  /// Código de barras no formato EAN-13 (JAN-13).
  static const JAN13 = EliginBarcodeType._internal(2);

  /// Código de barras no formato EAN-8 (JAN-8).
  static const JAN8 = EliginBarcodeType._internal(3);

  /// Código de barras no formato Code 39.
  static const CODE39 = EliginBarcodeType._internal(4);

  /// Código de barras no formato ITF (Interleaved 2 of 5).
  static const ITF = EliginBarcodeType._internal(5);

  /// Código de barras no formato Codabar.
  static const CODEBAR = EliginBarcodeType._internal(6);

  /// Código de barras no formato Code 93.
  static const CODE93 = EliginBarcodeType._internal(7);

  /// Código de barras no formato Code 128.
  static const CODE128 = EliginBarcodeType._internal(8);
}
