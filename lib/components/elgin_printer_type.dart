/// Enumeração dos tipos de conexão suportados para impressoras Elgin.
///
/// Utilize estas constantes para especificar a interface de comunicação
/// ao inicializar ou conectar com uma impressora pelo package.
///
/// Exemplo de uso:
/// ```dart
/// final printer = ElginPrinter(driver: ElginPrinterType.USB);
/// ```
class ElginPrinterType {
  /// Valor inteiro utilizado pelo protocolo para identificar o tipo de conexão.
  final int value;

  /// Construtor privado para uso interno.
  const ElginPrinterType._internal(this.value);

  /// Impressora conectada via USB.
  static const USB = ElginPrinterType._internal(1);

  /// Impressora conectada via porta serial.
  static const SERIAL = ElginPrinterType._internal(2);

  /// Impressora conectada via rede TCP/IP.
  static const TCP = ElginPrinterType._internal(3);

  /// Impressora conectada via Bluetooth.
  static const BLUETHOOTH = ElginPrinterType._internal(4);

  /// Impressora do tipo SmartPOS.
  static const SMARTPOS = ElginPrinterType._internal(5);

  /// Impressora do tipo MiniPDV.
  static const MINIPDV = ElginPrinterType._internal(6);
}
