import 'dart:async';

import 'package:elgin/services/printer.dart' show Printer;
import 'package:flutter/services.dart';

export 'package:elgin/components/enums.dart';
export 'package:elgin/components/exceptions/elgin_exception.dart';

/// Canal de comunicação entre Dart e a plataforma Android.
///
/// Este [MethodChannel] é utilizado para integrar chamadas nativas necessárias para os dispositivos Elgin.
final platform = const MethodChannel('elgin');

/// Classe principal de integração com dispositivos Elgin.
///
/// Centraliza o acesso às instâncias dos dispositivos suportados, como impressoras.
/// Futuramente, outros dispositivos poderão ser integrados através desta mesma interface.
class Elgin {
  /// Instância singleton para operações com impressoras Elgin.
  ///
  /// Utilize este getter para acessar todos os métodos relacionados à impressão.
  ///
  /// Exemplo:
  /// ```dart
  /// final status = await Elgin.printer.connect(driver: myPrinterConfig);
  /// ```
  static Printer get printer => Printer.instance(platform);

  /// Obtém a versão do sistema operacional da plataforma Android.
  ///
  /// Útil para exibir, registrar ou validar requisitos mínimos em tempo de execução.
  ///
  /// Retorna uma [String] com a versão do Android, ou `null` caso não seja possível obter a informação.
  static Future<String?> get platformVersion async =>
      await platform.invokeMethod('getPlatformVersion');
}
