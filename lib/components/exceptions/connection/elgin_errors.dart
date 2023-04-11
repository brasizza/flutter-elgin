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
