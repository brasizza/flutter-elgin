import 'package:elgin/components/elgin_printer_model.dart';
import 'package:elgin/components/elgin_printer_type.dart';

/// Classe que representa a configuração do driver da impressora Elgin.
///
/// Esta classe encapsula todos os parâmetros necessários para estabelecer
/// a conexão e comunicação com uma impressora Elgin, permitindo flexibilidade
/// para diferentes modelos e tipos de interface.
///
/// Exemplo de uso:
/// ```dart
/// final driver = ElginPrinter(
///   type: ElginPrinterType.USB,
///   model: ElginPrinterModel.MP4200,
///   connection: '/dev/usb/lp0',
///   parameter: 9600,
/// );
/// ```
class ElginPrinter {
  /// Tipo de conexão da impressora (USB, SERIAL, TCP, etc).
  final ElginPrinterType type;

  /// Modelo específico da impressora.
  ///
  /// Opcional. Caso não informado, o modelo padrão será utilizado.
  final ElginPrinterModel? model;

  /// Endereço, porta ou nome da conexão, de acordo com o tipo.
  ///
  /// Exemplos:
  /// - USB: caminho do dispositivo
  /// - SERIAL: porta serial
  /// - TCP: endereço IP ou hostname
  String? connection;

  /// Parâmetro adicional para configuração da conexão.
  ///
  /// Pode ser usado para baudrate, porta TCP, ou outro ajuste necessário para o tipo/modelo escolhido.
  int? parameter;

  /// Cria uma configuração de driver para impressora Elgin.
  ///
  /// [type]: tipo da impressora (obrigatório).
  /// [model]: modelo da impressora (opcional).
  /// [connection]: identificação ou endereço da conexão (opcional).
  /// [parameter]: parâmetro extra, como baudrate, porta, etc. (opcional).
  ElginPrinter({
    required this.type,
    this.model,
    this.connection,
    this.parameter,
  });
}
