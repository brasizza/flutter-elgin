# elgin
<h1> Package para trabalhar com os componentes da elgin <strong>SOMENTE em ANDROID! </strong></h1>

## INSTALANDO [EXTREMAMENTE IMPORTANTE SEGUIR ESSA PARTE]
Como se trata de um compomente que se comunica com libs externas, serão necessários fazer algumas (pouquissimas) modificações na sua pasta android.

1 - Na sua pasta android/app, mude o seu minSdk para 21 (**minSdkVersion 21**) , pois os componentes da elgin utilizam uma dependência que é necessário subir a versão.

2 - Baixar a última versão do sdk que estiver disponivel [SDK E1](https://github.com/ElginDeveloperCommunity/PDV_Android_M8_M10/blob/9f8f39a340176170e6b011473b49dae19462bded/Bibliotecas/E1_impressora01.04.04_Android.zip) - **No momento desse readme a versão das libs está em v1.0.10**

3 - ir no seu projeto , pasta *android/app* m criar uma pasta chamada **libs** e colocar todos os arquivos .aar lá dentro

4 - dentro da pasta app ainda, iremos precisar modificar o build.gradle, pois como ele utiliza libs de fora, também precisamos incluir no nosso package. No final do seu **android/app/build.gradle**, você irá colocar seguinte informação

```bash
- android/app/build.gradle
dependencies {  
    .... outras dependencias que você tiver no seu projeto ....
    implementation "androidx.startup:startup-runtime:1.0.0"
    implementation fileTree(include: ['*.aar'], dir: 'libs')
}
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


    final int? result = await Elgin.printer.connect(driver: driver);
    if(result != null){
      if(result == 0 ){
        await Elgin.printer.printString('HELLO PRINTER';
        await Elgin.printer.feed(2);
        await Elgin.printer.cut(2);
        await Elgin.printer.disconnect();
      }
    }
```
## Listagem de configurações disponíveis


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
