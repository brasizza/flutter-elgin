# elgin
Package para trabalhar com os componentes da elgin

##INSTALANDO [EXTREMAMENTE IMPORTANTE SEGUIR ESSA PARTE]
Como se trata de um compomente que se comunica com libs externas, serão necessários fazer algumas (pouquissimas) modificações na sua pasta android.

1 - no na sua pasta android/app, sua o minSdk para 24 (**minSdkVersion 24**)

# Iniciando
**Por mais que o código esteja em inglês, o readme e o CHANGELOG estarão em português para facilitar o entendimento**

Este package tem como finalidade ajudar os desenvolvedores que precisam utilizar algum componente da elgin/bematech, pois eles são bem chatos de configurar e acaba as vezes sendo bem frustrante!


 ## Package foi testado em:
```bash
Mini PDV M8
Mini PDV M10
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
