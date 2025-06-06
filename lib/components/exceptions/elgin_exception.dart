import 'connection/elgin_errors.dart';

/// Exceção personalizada para operações com dispositivos Elgin.
///
/// Esta exceção é lançada sempre que ocorre um erro durante as operações
/// com impressoras ou outros dispositivos Elgin. Ao ser criada, ela instancia
/// internamente um [ElginError] com o código informado, permitindo acessar
/// o tipo e a mensagem descritiva do erro.
///
/// Exemplo de uso:
/// ```dart
/// try {
///   await Elgin.printer.connect(driver: config);
/// } on ElginException catch (e) {
///   print('Erro: ${e.error.type} - ${e.error.message}');
/// }
/// ```
class ElginException implements Exception {
  /// Código do erro retornado pela operação.
  final int exception;

  /// Instância de [ElginError] correspondente ao código do erro.
  ///
  /// Fornece informações detalhadas sobre o tipo e a mensagem do erro.
  late final ElginError error;

  /// Cria uma nova exceção [ElginException] com o [exception] informado.
  ///
  /// O campo [error] será automaticamente preenchido.
  ElginException(this.exception) {
    error = ElginError(exception);
  }
}
