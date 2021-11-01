# elgin
<h1> Package para trabalhar com os componentes da elgin <strong>SOMENTE em ANDROID! </strong></h1>

## INSTALANDO [EXTREMAMENTE IMPORTANTE SEGUIR ESSA PARTE]
Como se trata de um compomente que se comunica com libs externas, serão necessários fazer algumas (pouquissimas) modificações na sua pasta android.

1 - Na sua pasta android/app, mude o seu minSdk para 24 (**minSdkVersion 24**) , pois os componentes da elgin utilizam uma dependência que é necessário subir a versão.

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

Esse package te ajudou? quer mais coisas nele ou outros devices elgin? Me ajude a manter o projeto ativo e implementar novos equipamentos (que provavelmente terei que adquirir)

[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.com/donate?business=5BMWJ9CYNVDAE&no_recurring=0&currency_code=BRL)
