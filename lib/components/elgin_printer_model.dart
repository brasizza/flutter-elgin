/// Enumeração dos modelos de impressoras Elgin suportados.
///
/// Utilize as constantes desta classe para selecionar o modelo correto
/// da impressora ao configurar uma conexão ou realizar operações de impressão.
///
/// Exemplo de uso:
/// ```dart
/// final printer = ElginPrinter(driver: ElginPrinterModel.MP4200);
/// ```
class ElginPrinterModel {
  /// Valor string que representa o modelo da impressora conforme o protocolo Elgin.
  final String value;

  /// Construtor privado para uso interno.
  const ElginPrinterModel._internal(this.value);

  /// Impressora modelo I7.
  static const I7 = ElginPrinterModel._internal("I7");

  /// Impressora modelo I8.
  static const I8 = ElginPrinterModel._internal("I8");

  /// Impressora modelo I9.
  static const I9 = ElginPrinterModel._internal("I9");

  /// Impressora modelo IX.
  static const IX = ElginPrinterModel._internal("IX");

  /// Impressora Fitpos.
  static const FITPOS = ElginPrinterModel._internal("Fitpos");

  /// Impressora modelo BK-T681.
  static const BKT681 = ElginPrinterModel._internal("BK-T681");

  /// Impressora modelo MP-4200.
  static const MP4200 = ElginPrinterModel._internal("MP-4200");

  /// Impressora modelo MP-2800.
  static const MP2800 = ElginPrinterModel._internal("MP-2800");

  /// Impressora modelo DR800.
  static const DR800 = ElginPrinterModel._internal("DR800");

  /// Impressora TCP genérica (padrão modelo I9).
  static const GENERIC_TCP = ElginPrinterModel._internal("I9");

  /// Impressora Print ID Touch.
  static const IDTOUCH = ElginPrinterModel._internal("Print ID Touch");

  /// Impressora SmartPOS.
  static const SMARTPOS = ElginPrinterModel._internal("SmartPOS");

  /// Impressora MiniPDV (M8).
  static const MINIPDV = ElginPrinterModel._internal("M8");
}
