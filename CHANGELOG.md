## 0.2.0
-Incremento do gradle para compileSdkVersion 34 no core do android 
Tks to [Shelmo](https://github.com/Shelmo)

## 0.2.0
-Incremento do gradle para compileSdkVersion 33 no core do android

-Incremento na versão do sdk pra 4.0.0



## 0.1.9
-Incremento do gradle para compileSdkVersion 33 
-Atualização da lib da elgin para e1-V02.16.00 
-Nenhum breakchange
-Upgrade de gradle e de alguns packages internos do android

## 0.1.8
-Incremento do gradle para compileSdkVersion 32 e targetSdkVersion 32
-Atualização da lib da elgin para e1-V02.15.01 
-Nenhum breakchange

## 0.1.7
-Incremento do readme com as novas features

## 0.1.6
-   Novas features!
- [x] Impressão de um XML SAT-  **printSAT**
- [x] Impressão de um XML NFCE (Precisa colocar o CSC, CSCID e um XML protocolado) - **printNFCE**
- [x] Impressão de um Cupom TEF (No exemplo eu passo um base64 e converto antes de enviar para a lib) - **printTEF**
- Sistema de Exceptions onde eu mapeei quase todos os erros possíveis da elgin
Um sistema de Exceptions feito para mapear a maiora das mensagens de erro da lib
```dart
 try {
    await Elgin.printer.cut();
    } on ElginException catch (e) {
        ///onde
        ///type = codigo em string do erro ex: PORTA_FECHADA
        print(e.error.type) ;
        ///message = texto detalhado em português ex: Porta de comunicação está fechada.
        print(e.error.message) ; 
    }
```

## 0.1.5
-   Limpeza do código do package, removendo arquivos desnecessários
## 0.1.4
-   Correção do README


## 0.1.3
-   Correção do método de desconectar que estava chamando o mehotdChannel errado

## 0.1.2
- Baixando o sdk para **minSdkVersion 21**
- Inclusão de uma aba *Listagem de configurações disponíveis* no README para exemplificar todas classes e configurações disponíveis

## 0.1.1
- Formatação do código

## 0.1.0

* Melhorias no código
-   Melhorias de separação dos enums para uma por arquivo para facilidar o entendimento
-   Criação de um componente *ElginPrinter* para configurar todos os parâmetros de impressoras disponíveis e enviar direto no método de conexão.
-   Teste em algumas impressoras:
    -   App de simulador de Impressora
    -   Epson TM-T20 (rede) - Com ressalvas no readme!
    -   Bluetooth da compex - Com ressalvas no readme!

## 0.0.1

* Release do projeto inicial.
Implementação inicial e testada somente em ** Mini PDV M8 e M10 **
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

