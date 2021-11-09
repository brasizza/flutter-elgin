# elgin
<h1> Package para trabalhar com os componentes da elgin <strong>SOMENTE em ANDROID! </strong></h1>

## INSTALANDO [EXTREMAMENTE IMPORTANTE SEGUIR ESSA PARTE]
Como se trata de um compomente que se comunica com libs externas, serão necessários fazer algumas (pouquissimas) modificações na sua pasta android.

1 - Na sua pasta android/app, mude o seu minSdk para 21 (**minSdkVersion 21**) , pois os componentes da elgin utilizam uma dependência que é necessário subir a versão.

2 - Baixar a última versão do sdk que estiver disponivel [SDK E1](https://github.com/ElginDeveloperCommunity/PDV_Android_M8_M10/blob/9f8f39a340176170e6b011473b49dae19462bded/Bibliotecas/E1_impressora01.04.04_Android.zip) - **No momento desse readme a versão das libs está em v1.0.10**

3 - ir no seu projeto , pasta **android/app** e criar uma pasta chamada **libs** e colocar todos os arquivos .aar lá dentro

4 - dentro da pasta app ainda, iremos precisar modificar o build.gradle, pois como ele utiliza libs de fora, também precisamos incluir no nosso package. No final do seu **android/app/build.gradle**, você irá colocar seguinte informação

```bash
- android/app/build.gradle
dependencies {  
    .... outras dependencias que você tiver no seu projeto ....
    implementation "androidx.startup:startup-runtime:1.0.0"
    implementation fileTree(include: ['*.aar'], dir: 'libs')
}
```

### Talvez você tenha que usar o comando tools:replace para dar um override no android:icon pois o minipdv8 também está setando essa propriedade

```xml
 <application
        android:name="io.flutter.app.FlutterApplication"
        tools:replace="android:label,android:icon"
        ... Resto do seu application aqui

>
```

e assim seu projeto estará funcionando.

# Iniciando
**Por mais que o código esteja em inglês, o readme e o CHANGELOG estarão em português para facilitar o entendimento**

Este package tem como finalidade ajudar os desenvolvedores que precisam utilizar algum componente da elgin/bematech, pois eles são bem chatos de configurar e acaba as vezes sendo bem frustrante!


 ## Package foi testado em:
```bash
Mini PDV M8 
Mini PDV M10
Virtual Printer - https://play.google.com/store/apps/details?id=pl.glpro.virtualthermalprinter (PAGO)
EPSON TM-20 -  (Não funciona todas os modelos de impressão da impressao, mas aceita o esc pos)
BLUETOOTH PT-380  - COMPEX (Não funciona muito bem o escpos e impressão de imagem)
```

### Portanto se você quiser ajudar a homologar mais aparelhos me contate para que possamos agilizar esse processo   
## O que o package faz até o momento  (além de conectar e desconectar a impressora)


- [x] Escreve uma linha ou um texto estilizado (tipos de estilo no final do readme) -  **printString**
- [x] Avança x linhas à sua escolha - **feed**
- [x] Faz o corte de papel com a configuração de pular linha após - **cut**
- [x] Imprime códigos de barras de todos os estilos e modelos (tipos de modelos no final do readme) - **printBarCode**
- [x] Imprime qrcodes com todos os tipos de correções e tamanhos - **printQRCode**
- [x] Envia comando escpos diretamente para impressora, caso você já tenha um script de escpos é só utilizar este comando  - **printRaw**
- [x] Envia um beep para a impressoa (algumas não tem essa funcionalidade)  - **beep**
- [x] Opção de utilizar gavetas da elgin ou qualquer outra customizado  - **customCashier**/**elginCashier**
- [x] Desenha uma linha com o caractere customizável para separar áreas de impressão  - **line**
- [x] Imprime uma imagem tanto vinda da web quanto de algum asset (ver exemplo) - **printImage**
- [x] Pega versão da lib, status de papel, ejetor e da gaveta (caso tenha) 


## No exemplo existe o teste de conexão para as 4 tipos de impressoras ##
* Troque os IPs , Mac Address e modelo das impressoras para testar no seu ambiente.


**Tela com as funcionalidades de exemplo**
<p align="left">
  <img src="https://marcus.brasizza.com/imagens/example-elgin.png"  
  title="Todas as funcionalidades">
</p>

## Comandos básicos para conexão ##

```dart
    final _driver = ElginPrinter(
        type: ElginPrinterType.TCP,
        model: ElginPrinterModel.GENERIC_TCP,
        connection: '192.168.5.111',
        parameter: 9100,
    );

    ///OU UTILIZANDO DIRETO NO MINI PDV
    final _driver = ElginPrinter(type: ElginPrinterType.MINIPDV);

    try{
    final int? result = await Elgin.printer.connect(driver: driver);
    if(result != null){
      if(result == 0 ){
        await Elgin.printer.printString('HELLO PRINTER';
        await Elgin.printer.feed(2);
        await Elgin.printer.cut(2);
        await Elgin.printer.disconnect();
      }
    }
    }on ElginException catch (e) {
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.error.message)));
     }
   
```
## Listagem de configurações disponíveis


<details>
<summary><strong>Erros que são capturados pela exception</strong></summary>


```dart
  ///*ElginError
///
///Where in the barcode the text will be show
class ElginError {
  int code = 999;
  String type = "";
  String message = "";
  ElginError(
    this.code,
  ) {
    switch (code) {

      /// GER_Erro_Conexao

      case -2:
        type = 'TIPO_INVALIDO';
        message = 'Tipo informado não corresponde a USB, RS232 ou TCP/IP.';
        break;

      case -3:
        type = 'MODELO_INVALIDO';
        message =
            'Modelo de impressora informado é invalido ou não é suportado nessa versão.';
        break;

      case -4:
        type = 'DISPOSITIVO_NAO_ENCONTRADO';
        message = 'Porta de comunicação está fechada.';
        break;

      case -5:
        type = 'DISPOSITIVO_NAO_ENCONTRADO';
        message = ' Impressora não é uma impressora ELGIN.';
        break;

      case -6:
        type = 'DISPOSITIVO_NAO_ENCONTRADO';
        message = 'Conexão já está em aberto.';
        break;

      /// GER_Erro_Conexao_Serial

      case -11:
        type = 'BAUDRATE_INVALIDO';
        message = 'O baudrate informado é invalido para conexão.';
        break;

      case -12:
        type = 'DISPOSITIVO_NAO_EXISTE';
        message = "O dispositivo não existe para conexão.";
        break;
      case -13:
        type = 'PERMISSAO_NEGADA';
        message = 'Dispositivo já está aberto ou usuário não tem permissão.';
        break;

      case -14:
        type = 'ERRO_SERIAL_DESCONHECIDO';
        message = 'Erro desconhecido na conexão serial.';
        break;
      case -15:
        type = 'DISPOSITIVO_JA_ESTA_ABERTO';
        message = 'Tentativa de abrir um dispositivo já aberto.';
        break;

      case -16:
        type = 'RECURSO_INDISPONIVEL';
        message =
            'Tentativa de acessar um recurso indisponível (removido do sistema, por exemplo).';
        break;
      case -17:
        type = 'OPERACAO_NAO_SUPORTADA';
        message = 'Operação não suportada pelo sistema operacional em uso.';
        break;

      case -18:
        type = 'SERIAL_TIMEOUT';
        message = 'Erro de timeout.';
        break;
      case -19:
        type = 'DISPOSITIVO_REMOVIDO_INESPERADAMENTE';
        message =
            'Ocorreu um erro de E/S quando um recurso se tornou indisponível, por exemplo, quando o dispositivo é removido inesperadamente do sistema.';
        break;

      /// GER_Erro_Conexao_USB

      case -21:
        type = 'DISPOSITIVO_NAO_ENCONTRADO';
        message = 'O dispositivo não foi encontrado.';
        break;
      case -22:
        type = 'ERRO_DE_ABERTURA_PORTA_USB';
        message = 'Erro ao tentar abrir a porta de comunicação.';
        break;

      case -23:
        type = 'ERRO_CLAIM_UL';
        message =
            'Erro ao tentar reivindicar a interface do identificador do dispositivo.';
        break;

      /// GER_Erro_Conexao_TCP

      case -31:
        type = 'PORTA_TCP_INVALIDA';
        message = 'Porta TCP/IP está fora dos limites.';
        break;

      /// Erro_ConexaoAndroid

      case -171:
        type = 'RECONEXOES_ESGOTADAS';
        message =
            'Instância da classe atingiu valor limite de reconexões do tipo.';
        break;

      case -172:
        type = 'CONEXAO_ATIVA_OUTRO';
        message = 'Outro tipo de dispositivo está usando a conexão.';
        break;

      case -173:
        type = 'ERRO_ABERTURA_PORTA';
        message = 'Erro na abertura da porta.';
        break;

      case -174:
        type = 'ERRO_FECHAMENTO_PORTA';
        message = 'Erro no fechamento da porta.';
        break;

      case -175:
        type = 'ERRO_ESCRITA_PORTA';
        message = 'Erro de escrita na porta.';
        break;

      case -176:
        type = 'ERRO_NENHUM_BYTE_ENVIADO';
        message = 'Nenhum byte foi enviado à impressora.';
        break;

      case -177:
        type = 'ERRO_LEITURA_PORTA';
        message = 'Erro de leitura na porta.';
        break;

      case -391:
        type = 'MAC_ADDRESS_INVALIDO';
        message = 'Mac Address inválido para conexão Bluetooth.';
        break;

      case -392:
        type = 'DISPOSITIVO_NAO_SUPORTA_BT';
        message = 'Dispositivo não suporta Bluetooth.';
        break;

      case -393:
        type = 'BLUETOOTH_DESATIVADO';
        message = 'Bluetooth do dispositivo está desativado.';
        break;

      case -394:
        type = 'DISPOSITIVO_NAO_PAREADO';
        message = 'Dispositivo não está pareado.';
        break;

      case -395:
        type = 'ERRO_CONEXAO_BLUETOOTH';
        message = 'Erro ao iniciar conexão Bluetooth.';
        break;

      ///IMP_Erro_Escrita_Impressora

      case -41:
        type = 'POSICAO_INVALIDA';
        message = 'Posição de impressão está fora dos limites';
        break;

      case -42:
        type = 'STILO_INVALIDO';
        message = 'Estilo de letra inválido';
        break;

      case -43:
        type = 'TAMANHO_INVALIDO';
        message = 'Tamanho de letra inválido.';
        break;

      case -44:
        type = 'ERRO_ESCRITA';
        message = 'Erro na tentativa de escrita na porta de comunicação.';
        break;

      /// IMP_Erro_QRCode

      case -51:
        type = 'TAMANHO_QR_INVALIDO';
        message = 'Tamanho do QRCode informado está fora dos limites';
        break;

      case -52:
        type = 'NIVEL_DE_CORRECAO_INVALIDO';
        message = 'Nivel de correção incorreto.';
        break;

      case -53:
        type = 'DADOS_QR_INVALIDOS';
        message = 'Dados informados não são válidos.';
        break;

      ///IMP_Erro_CodigoBarras

      case -61:
        type = 'CB_ALTURA_INVALIDA';
        message = 'Altura informada está fora dos limites.';
        break;

      case -62:
        type = 'CB_LARGURA_INVALIDA';
        message = ' Largura informada está fora dos limites.';
        break;

      case -63:
        type = 'CB_HRI_INVALIDO';
        message = 'HRI informado está fora dos limites.';
        break;

      case -64:
        type = 'CB_TIPO_INVALIDO';
        message = 'O tipo de código de barras não existe.';
        break;

      case -65:
        type = 'CB_DADOS_INVALIDOS';
        message =
            'Os dados informados não estão de acordo com o padrão aceito para o código de barras.';
        break;

      case -66:
        type = 'CB_AREA_DE_IMPRESSAO_EXCEDIDA';
        message = 'Código de barras atingiu a área de impressão.';
        break;

      /// IMP_Erro_Status

      case -126:
        type = 'STATUS_NAO_SUPORTADO';
        message =
            'Status solicitado não suportado para o modelo de impressora selecionado.';
        break;

      case -127:
        type = 'PARAMETRO_TIPO_STATUS_INVALIDO';
        message = 'Especificação do status inválida.';
        break;

      /// IMP_Erro_Leitura_Impressora

      case -81:
        type = 'NENHUM_DADO_RETORNADO';
        message = 'Nenhum dado retornou na tentativa de leitura.';
        break;

      ///  Erro_Outros

      case -401:
        type = 'ERRO_FUNCAO_NAO_SUPORTADA';
        message = 'Dispositivo não suporta a função chamada.';
        break;

      case -402:
        type = 'ERRO_ID_INVALIDO';
        message = 'Parâmetro ID está fora dos limites.';
        break;

      case -403:
        type = 'ERRO_SERVICO_NAO_INICIADO';
        message = 'A função foi chamada sem o serviço estar iniciado.';
        break;

      case -404:
        type = 'ERRO_ABERTURA_NAO_AUTORIZADA';
        message = 'Tentativa não autorizada para iniciar o serviço.';
        break;

      case -405:
        type = 'ERRO_FECHAMENTO_NAO_AUTORIZADO';
        message = 'Tentativa não autorizada para encerrar o serviço.';
        break;

      case -406:
        type = 'ERRO_FUNCAO_NAO_CHAMADA_PELO_SERVICO';
        message = 'A função não foi chamada pelo módulo do serviço.';
        break;

      case -407:
        type = 'ERRO_FUNCAO_NAO_DISPONIVEL_VIA_SERVICO';
        message = 'A função não está disponível para uso com o serviço.';
        break;

      /// IMP_Erro_Abertura_Gaveta

      case -121:
        type = 'PINO_INVALIDO';
        message = 'Idicação de pino inválida.';
        break;

      case -122:
        type = 'TEMPO_INVALIDO';
        message = 'Tempo de acionamento inválido';
        break;

      /// IMP_Erro_Imagem
      case -131:
        type = 'KEY_INVALIDO';
        message =
            'Key da imagem está fora dos limites. Valor de (CHAR)32 à (CHAR)126.';
        break;

      case -132:
        type = 'SCALA_INVALIDA';
        message = 'Scala está fora dos limites. Valor de 1 ou 2.';
        break;

      /// MP_Erro_ValidacaoXML
      case -71:
        type = 'ERRO_XSD';
        message = 'Um problema com o XSD foi encontrado.';
        break;

      case -72:
        type = 'XSD_NAO_ENCONTRADO';
        message = 'Arquivo de validação XML não foi encontrado.';
        break;

      ///  IMP_Erro_ValidacaoXMLSAT
      case -91:
        type = 'ASSINATURA_QRCODE_INVALIDA';
        message = 'Assinatura para o QRCode inválida.';
        break;

      case -92:
        type = 'DADOS_XML_VAZIO';
        message = 'Função não recebeu os dados de impressão.';
        break;

      case -93:
        type = 'DADOS_XML_INVALIDO';
        message = 'Função não pode reconheceu os dados enviados.';
        break;

      case -94:
        type = 'ARQUIVO_XML_NAO_PODE_SER_ABERTO';
        message = 'Função não pode abrir o arquivo informado.';
        break;

      case -95:
        type = 'ARQUIVO_XML_NAO_CONTEM_DADOS';
        message = 'O Arquivo informado está vazio';
        break;

      // IMP_Erro_ValidacaoXMLNFCe

      case -101:
        type = 'VERSAO_XMLNFCE_NAO_SUPORTADA';
        message =
            'A versão do XML enviado para impressão não é suportada. Atualmente a versão suportada é a 4.00';
        break;

      case -102:
        type = 'VERSAO_XMLNFCE_INDEFINIDA';
        message = 'Não foi possível definir a versão do XML enviado.';
        break;

      case -103:
        type = 'TIPO_EMISSAO_INDEFINIDA';
        message =
            'Tipo de emissão não encontrada no XML.Valor referente a TAG tpEmis do XML, utilizado para imprimir cupom em contingência.';
        break;

      ///DEFAULT ERROR

      case -9999:
      default:
        type = 'ERRO_DESCONHECIDO';
        message = 'Erro desconhecido ou não capturado ($code)';

        break;
    }
  }
}
```
</details>

<details>
<summary><strong>Modelo de impressoras disponíveis (componente)</strong></summary>

```dart
class ElginPrinterModel {
  const ElginPrinterModel._internal(this.value);
  final String value;

  static const I7 = ElginPrinterModel._internal("I7");
  static const I8 = ElginPrinterModel._internal("I8");
  static const I9 = ElginPrinterModel._internal("I9");
  static const IX = ElginPrinterModel._internal("IX");
  static const FITPOS = ElginPrinterModel._internal("Fitpos");
  static const BKT681 = ElginPrinterModel._internal("BK-T681");
  static const MP4200 = ElginPrinterModel._internal("MP-4200");
  static const MP2800 = ElginPrinterModel._internal("MP-2800");
  static const DR800 = ElginPrinterModel._internal("DR800");
  static const GENERIC_TCP = ElginPrinterModel._internal("I9");
  static const IDTOUCH = ElginPrinterModel._internal("Print ID Touch");
  static const SMARTPOS = ElginPrinterModel._internal("SmartPOS");
  static const MINIPDV = ElginPrinterModel._internal("M8");
}
```
</details>

<details>
<summary><strong>Tipos disponíveis para conexões de impressoras</strong></summary>

```dart
class ElginPrinterType {
  const ElginPrinterType._internal(this.value);
  final int value;
  static const USB = ElginPrinterType._internal(1);
  static const SERIAL = ElginPrinterType._internal(2);
  static const TCP = ElginPrinterType._internal(3);
  static const BLUETHOOTH = ElginPrinterType._internal(4);
  static const SMARTPOS = ElginPrinterType._internal(5);
  static const MINIPDV = ElginPrinterType._internal(6);
}
```
</details>

<details>
<summary><strong>Tipos de código de barras</strong></summary>

```dart
class EliginBarcodeType {
  const EliginBarcodeType._internal(this.value);
  final int value;
  static const UPCA = EliginBarcodeType._internal(0);
  static const UPCE = EliginBarcodeType._internal(1);
  static const JAN13 = EliginBarcodeType._internal(2);
  static const JAN8 = EliginBarcodeType._internal(3);
  static const CODE39 = EliginBarcodeType._internal(4);
  static const ITF = EliginBarcodeType._internal(5);
  static const CODEBAR = EliginBarcodeType._internal(6);
  static const CODE93 = EliginBarcodeType._internal(7);
  static const CODE128 = EliginBarcodeType._internal(8);
}
```

</details>

<details>
<summary><strong>Posicionamento do texto no código de barras</strong></summary>

```dart
class ElginBarcodeTextPosition {
  const ElginBarcodeTextPosition._internal(this.value);
  final int value;
  static const NO_TEXT = ElginBarcodeTextPosition._internal(4);
  static const TEXT_ABOVE = ElginBarcodeTextPosition._internal(1);
  static const TEXT_UNDER = ElginBarcodeTextPosition._internal(2);
  static const BOTH = ElginBarcodeTextPosition._internal(3);
}
```
</details>


<details>
<summary><strong>Tipos de alinhamentos</strong></summary>

```dart
class ElginAlign {
  const ElginAlign._internal(this.value);
  final int value;
  static const LEFT = ElginAlign._internal(0);
  static const CENTER = ElginAlign._internal(1);
  static const RIGHT = ElginAlign._internal(2);
}
```
</details>



<details>
<summary><strong>Fontes disponíveis</strong></summary>

```dart
class ElginFont {
  const ElginFont._internal(this.value);
  final int value;
  static const FONTA = ElginFont._internal(0);
  static const FONTB = ElginFont._internal(1);
  static const UNDERLINE = ElginFont._internal(2);
  static const BOLD = ElginFont._internal(8);
  static const REVERSE = ElginFont._internal(4);
}
```
</details>

<details>
<summary><strong>Tamanho de fontes disponíveis</strong></summary>

```dart
class ElginSize {
  const ElginSize._internal(this.value);
  final int value;
  static const MD = ElginSize._internal(0);
  static const LG = ElginSize._internal(16);
  static const XL = ElginSize._internal(24);
}
```
</details>

<details>
<summary><strong>Tamanho do Qrcode</strong></summary>

```dart
class ElginQrcodeSize {
  const ElginQrcodeSize._internal(this.value);
  final int value;
  static const SIZE1 = ElginQrcodeSize._internal(1);
  static const SIZE2 = ElginQrcodeSize._internal(2);
  static const SIZE3 = ElginQrcodeSize._internal(3);
  static const SIZE4 = ElginQrcodeSize._internal(4);
  static const SIZE5 = ElginQrcodeSize._internal(5);
  static const SIZE6 = ElginQrcodeSize._internal(6);
}
```
</details>


<details>
<summary><strong>Níveis de correção do Qrcode</strong></summary>

```dart
class ElginQrcodeCorrection {
  const ElginQrcodeCorrection._internal(this.value);
  final int value;
  static const LEVEL_L = ElginQrcodeCorrection._internal(1);
  static const LEVEL_M = ElginQrcodeCorrection._internal(2);
  static const LEVEL_Q = ElginQrcodeCorrection._internal(3);
  static const LEVEL_H = ElginQrcodeCorrection._internal(4);
}
```
</details>

<details>
<summary><strong>Objeto de configuração da impressora</strong></summary>


```dart
  final ElginPrinterType type;
  final ElginPrinterModel? model;
  String? connection;
  int? parameter;
  ElginPrinter({
    required this.type,
    this.model,
    this.connection,
    this.parameter,
  });
}
```
</details>


<br>
<hr>
Esse package te ajudou? quer mais coisas nele ou outros devices elgin? Me ajude a manter o projeto ativo e implementar novos equipamentos (que provavelmente terei que adquirir)

[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.com/donate?business=5BMWJ9CYNVDAE&no_recurring=0&currency_code=BRL)
