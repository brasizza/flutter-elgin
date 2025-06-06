import 'dart:io' show File;

import 'package:elgin/components/enums.dart';
import 'package:elgin/components/exceptions/elgin_exception.dart';
import 'package:flutter/services.dart';

/// Classe principal para integração com impressoras Elgin.
///
/// Esta classe fornece métodos de alto nível para realizar operações com impressoras Elgin,
/// incluindo impressão de textos, códigos de barras, QR Codes, imagens, abertura de gaveta,
/// corte de papel, verificação de status e muito mais.
///
/// Instancie a classe utilizando o método estático [instance].
class Printer {
  static MethodChannel? platform;
  static Printer? _instance;

  Printer._();

  /// Emite um sinal sonoro (beep) na impressora, se suportado.
  ///
  /// [times]: quantidade de vezes que o beep será emitido.
  /// [st]: tempo de sinalização do beep.
  /// [ft]: frequência do beep.
  ///
  /// Retorna o código de status da operação.
  /// Lança [ElginException] em caso de erro.
  Future<int> beep(int times, int st, int ft) async {
    final mapParam = {'times': times, 'st': st, 'ft': ft};
    final beep =
        await platform?.invokeMethod("beep", {'beepArgs': mapParam}) ?? 9999;
    if (beep < 0) throw ElginException(beep);
    return beep;
  }

  /// Conecta-se à impressora utilizando as informações do driver [ElginPrinter].
  ///
  /// Antes de executar qualquer operação, a impressora precisa estar conectada.
  ///
  /// [driver]: configuração da impressora a ser utilizada.
  ///
  /// Retorna o código de status da operação.
  /// Lança [ElginException] em caso de erro.
  Future<int?> connect({required ElginPrinter driver}) async {
    final mapParam = {
      'type': driver.type.value,
      'model': driver.model?.value ?? 'M8',
      'connection': driver.connection ?? '',
      'param': driver.parameter ?? 0,
    };
    final connect =
        await platform?.invokeMethod('startInternalPrinter', {
          'printerArgs': mapParam,
        }) ??
        9999;
    if (connect < 0) throw ElginException(connect);
    return connect;
  }

  /// Desconecta a impressora do sistema.
  ///
  /// É recomendável chamar este método ao encerrar o uso da impressora.
  ///
  /// Retorna o código de status da operação.
  /// Lança [ElginException] em caso de erro.
  Future<int?> disconnect() async {
    final disconnect =
        ((await platform?.invokeMethod('stopPrinter') ?? false) == false
        ? -1
        : 9999);
    if (disconnect < 0) throw ElginException(disconnect);
    return disconnect;
  }

  /// Imprime um documento SAT a partir de um XML fornecido.
  ///
  /// [xml]: conteúdo XML do SAT.
  /// [param]: parâmetros opcionais para impressão.
  ///
  /// Retorna o código de status da operação.
  /// Lança [ElginException] em caso de erro.
  Future<int?> printSAT(String xml, {int param = 0}) async {
    final mapParam = {'xmlSAT': xml, 'param': param};
    final printSAT =
        await platform?.invokeMethod("printSAT", {'satArgs': mapParam}) ?? 9999;
    if (printSAT < 0) throw ElginException(printSAT);
    return printSAT;
  }

  /// Imprime um documento NFC-e a partir de um XML fornecido.
  ///
  /// [xml]: conteúdo XML da NFC-e.
  /// [csc]: código de segurança do contribuinte.
  /// [cscId]: identificador do CSC.
  /// [param]: parâmetros opcionais para impressão.
  ///
  /// Retorna o código de status da operação.
  /// Lança [ElginException] em caso de erro.
  Future<int?> printNFCE(
    String xml,
    String csc,
    int cscId, {
    int param = 0,
  }) async {
    final mapParam = {
      'xmlNFCe': xml,
      'indexcsc': cscId,
      'csc': csc,
      'param': param,
    };
    final printNfce =
        await platform?.invokeMethod("printNFCE", {'nfceArgs': mapParam}) ??
        9999;
    if (printNfce < 0) throw ElginException(printNfce);
    return printNfce;
  }

  /// Imprime um cupom TEF a partir de um texto fornecido.
  ///
  /// [cupomTEF]: texto do cupom a ser impresso.
  ///
  /// Retorna o código de status da operação.
  /// Lança [ElginException] em caso de erro.
  Future<int?> printTEF(String cupomTEF) async {
    final printTEF =
        await platform?.invokeMethod("printTEF", {'cupomTEF': cupomTEF}) ??
        9999;
    if (printTEF < 0) throw ElginException(printTEF);
    return printTEF;
  }

  /// Abre a gaveta de dinheiro personalizada.
  ///
  /// Permite configurar pino, intervalo e duração de pulso para gavetas de outros fabricantes.
  ///
  /// [pin]: número do pino.
  /// [it]: intervalo.
  /// [dp]: duração do pulso.
  ///
  /// Retorna o código de status da operação.
  /// Lança [ElginException] em caso de erro.
  Future<int> customCashier(int pin, int it, int dp) async {
    final mapParam = {'pin': pin, 'it': it, 'dp': dp};
    final customCash =
        await platform?.invokeMethod("customCashier", {
          'cashierArgs': mapParam,
        }) ??
        9999;
    if (customCash < 0) throw ElginException(customCash);
    return customCash;
  }

  /// Executa o corte do papel, pulando [lines] linhas antes de cortar.
  ///
  /// [lines]: número de linhas a avançar antes do corte.
  ///
  /// Retorna o código de status da operação.
  /// Lança [ElginException] em caso de erro.
  Future<int> cut({int lines = 0}) async {
    final cut =
        await platform?.invokeMethod("cutPaper", {'lines': lines}) ?? 9999;
    if (cut < 0) throw ElginException(cut);
    return cut;
  }

  /// Abre a gaveta de dinheiro padrão Elgin.
  ///
  /// Use este método para gavetas compatíveis Elgin.
  ///
  /// Retorna o código de status da operação.
  /// Lança [ElginException] em caso de erro.
  Future<int> elginCashier() async {
    final elginCash = await platform?.invokeMethod('elginCashier') ?? 9999;
    if (elginCash < 0) throw ElginException(elginCash);
    return elginCash;
  }

  /// Avança [lines] linhas no papel da impressora.
  ///
  /// [lines]: quantidade de linhas para avançar.
  ///
  /// Retorna o código de status da operação.
  /// Lança [ElginException] em caso de erro.
  Future<int> feed(int lines) async {
    final feed =
        await platform?.invokeMethod('feedLine', {'lines': lines}) ?? 9999;
    if (feed < 0) throw ElginException(feed);
    return feed;
  }

  /// Obtém a versão da biblioteca de integração em uso.
  ///
  /// Retorna uma [String] com a versão atual da biblioteca.
  Future<String> get libVersion async =>
      await platform?.invokeMethod('libVersion');

  /// Imprime uma linha de caracteres para separação visual no papel.
  ///
  /// [ch]: caractere utilizado para desenhar a linha.
  /// [len]: comprimento da linha.
  Future<void> line({String ch = '-', int len = 31}) async {
    await printString(List.filled(len, ch[0]).join());
  }

  /// Imprime um código de barras na impressora.
  ///
  /// [text]: valor a ser codificado.
  /// [barcodeType]: tipo do código de barras ([EliginBarcodeType]).
  /// [align]: alinhamento na impressão.
  /// [height]: altura do código.
  /// [width]: largura do código.
  /// [textPosition]: posição do texto sob o código de barras.
  ///
  /// Retorna o código de status da operação.
  /// Lança [ElginException] em caso de erro.
  Future<int> printBarCode(
    String text, {
    EliginBarcodeType barcodeType = EliginBarcodeType.JAN8,
    ElginAlign align = ElginAlign.RIGHT,
    int height = 50,
    int width = 6,
    ElginBarcodeTextPosition textPosition = ElginBarcodeTextPosition.NO_TEXT,
  }) async {
    await reset();
    final mapParam = {
      'barCodeType': barcodeType.value,
      'text': text,
      'height': height,
      'align': align.value,
      'width': width,
      'textPosition': textPosition.value,
    };
    final barcode =
        await platform?.invokeMethod("printBarCode", {
          'barcodeArgs': mapParam,
        }) ??
        9999;
    if (barcode < 0) throw ElginException(barcode);
    return barcode;
  }

  /// Imprime uma imagem a partir de um arquivo [File].
  ///
  /// [image]: arquivo da imagem.
  /// [isBase64]: se a imagem está codificada em base64.
  ///
  /// Retorna o código de status da operação.
  /// Lança [ElginException] em caso de erro.
  Future<int> printImage(File image, bool isBase64) async {
    await reset();
    final mapParam = {'path': image.path, 'isBase64': isBase64};
    final image0 =
        await platform?.invokeMethod('printImage', {'imageArgs': mapParam}) ??
        9999;
    if (image0 < 0) throw ElginException(image0);
    return image0;
  }

  /// Imprime um QR Code com opções de alinhamento, tamanho e correção.
  ///
  /// [text]: texto a ser codificado.
  /// [size]: tamanho do QR Code.
  /// [align]: alinhamento.
  /// [correction]: nível de correção de erro.
  ///
  /// Retorna o código de status da operação.
  /// Lança [ElginException] em caso de erro.
  Future<int> printQRCode(
    String text, {
    ElginQrcodeSize size = ElginQrcodeSize.SIZE4,
    ElginAlign align = ElginAlign.CENTER,
    ElginQrcodeCorrection correction = ElginQrcodeCorrection.LEVEL_M,
  }) async {
    await reset();
    final mapParam = {
      'size': size.value,
      'align': align.value,
      'correction': correction.value,
      'text': text,
    };
    final qrcode =
        await platform?.invokeMethod("printQrcode", {'qrcodeArgs': mapParam}) ??
        9999;
    if (qrcode < 0) throw ElginException(qrcode);
    return qrcode;
  }

  /// Envia um comando ESC/POS bruto diretamente para a impressora.
  ///
  /// Permite total controle sobre o hardware via comandos binários.
  ///
  /// [rawList]: lista de bytes a serem enviados.
  ///
  /// Retorna o código de status da operação.
  /// Lança [ElginException] em caso de erro.
  Future<int> printRaw(List<int> rawList) async {
    await reset();
    final list = Uint8List.fromList(rawList);
    final mapParam = {'data': list, 'bytes': list.lengthInBytes};
    final raw =
        await platform?.invokeMethod('printRaw', {'rawArgs': mapParam}) ?? 9999;
    if (raw < 0) throw ElginException(raw);
    return raw;
  }

  /// Imprime uma string de texto na impressora, com opções de formatação.
  ///
  /// [text]: texto a ser impresso.
  /// [align]: alinhamento do texto ([ElginAlign]).
  /// [isBold]: *DEPRECATED* - não possui efeito nas impressoras Elgin.
  /// [isUnderline]: *DEPRECATED* - não possui efeito nas impressoras Elgin.
  /// [font]: tipo da fonte.
  /// [fontSize]: tamanho da fonte.
  ///
  /// Retorna o código de status da operação.
  /// Lança [ElginException] em caso de erro.
  Future<int> printString(
    String text, {
    ElginAlign align = ElginAlign.LEFT,
    @Deprecated(
      'Não tem efeito real nas impressoras Elgin e será removido em versões futuras.',
    )
    bool isBold = false,
    @Deprecated(
      'Não tem efeito real nas impressoras Elgin e será removido em versões futuras.',
    )
    bool isUnderline = false,
    ElginFont font = ElginFont.FONTA,
    ElginSize fontSize = ElginSize.MD,
  }) async {
    await reset();
    final mapParam = {
      'text': text,
      'align': align.value,
      'font': font.value,
      'fontSize': fontSize.value,
    };
    final print =
        await platform?.invokeMethod('printText', {"textArgs": mapParam}) ??
        9999;
    if (print < 0) throw ElginException(print);
    feed(1);
    return print;
  }

  /// Restaura as configurações padrão da impressora.
  ///
  /// Este método não limpa o buffer de impressão, apenas reseta os parâmetros.
  ///
  /// Retorna o código de status da operação.
  /// Lança [ElginException] em caso de erro.
  Future<int> reset() async {
    final reset = await platform?.invokeMethod('reset') ?? 9999;
    if (reset < 0) throw ElginException(reset);
    return reset;
  }

  /// Retorna o status atual da gaveta de dinheiro.
  ///
  /// Útil para verificar se há uma gaveta conectada e operacional.
  ///
  /// Retorna o código de status da operação.
  /// Lança [ElginException] em caso de erro.
  Future<int> statusCashier() async {
    final status = await platform?.invokeMethod('statusCashier') ?? 9999;
    if (status < 0) throw ElginException(status);
    return status;
  }

  /// Retorna o status do ejetor de papel, caso o hardware possua o recurso.
  ///
  /// Retorna o código de status da operação.
  /// Lança [ElginException] em caso de erro.
  Future<int> statusEjetor() async {
    final status = await platform?.invokeMethod('statusEjector') ?? 9999;
    if (status < 0) throw ElginException(status);
    return status;
  }

  /// Retorna o status do sensor de papel.
  ///
  /// Útil para checar se há papel disponível na impressora.
  ///
  /// Retorna o código de status da operação.
  /// Lança [ElginException] em caso de erro.
  Future<int> statusSensor() async {
    final status = await platform?.invokeMethod('statusSensor') ?? 9999;
    if (status < 0) throw ElginException(status);
    return status;
  }

  /// Retorna a instância singleton da classe [Printer].
  ///
  /// [methodChannel]: canal de comunicação nativo com o plugin.
  static Printer instance(MethodChannel methodChannel) {
    platform = methodChannel;
    _instance ??= Printer._();
    return _instance!;
  }
}
