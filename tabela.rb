# frozen_string_literal: true

require 'faraday'
require 'faraday_middleware'
require 'faraday_middleware/parse_oj'

module Fipe
  class Tabela
    BASE_URL = 'http://veiculos.fipe.org.br'

    MESES = {
      "janeiro": 1,
      "fevereiro": 2,
      "março": 3,
      "abril": 4,
      "maio": 5,
      "junho": 6,
      "julho": 7,
      "agosto": 8,
      "setembro": 9,
      "outubro": 10,
      "novembro": 11,
      "dezembro": 12
    }.freeze

    def initialize
      @conn = Faraday.new(url: BASE_URL) do |builder|
        builder.request :json
        builder.response :oj
        builder.adapter Faraday.default_adapter
      end

      @conn.headers['Referer'] = 'http://veiculos.fipe.org.br/'
    end

    def referencias
      response = @conn.post('/api/veiculos/ConsultarTabelaDeReferencia')

      response.body
    end

    def marcas(tipo_veiculo, referencia = ultimo_periodo_referencia['Codigo'])
      referencia ||= ultimo_periodo_referencia['Codigo']

      response = @conn.post('/api/veiculos/ConsultarMarcas',
                            codigoTipoVeiculo: tipo_veiculo,
                            codigoTabelaReferencia: referencia)

      response.body
    end

    def modelos(tipo_veiculo, marca, referencia = ultimo_periodo_referencia['Codigo'])
      referencia ||= ultimo_periodo_referencia['Codigo']

      response = @conn.post('/api/veiculos/ConsultarModelos',
                            codigoTipoVeiculo: tipo_veiculo,
                            codigoMarca: marca,
                            codigoTabelaReferencia: referencia)

      response.body['Modelos']
    end

    def ano_modelos(tipo_veiculo, marca, modelo, referencia = ultimo_periodo_referencia['Codigo'])
      referencia ||= ultimo_periodo_referencia['Codigo']

      response = @conn.post('/api/veiculos/ConsultarAnoModelo',
                            codigoTipoVeiculo: tipo_veiculo,
                            codigoMarca: marca,
                            codigoModelo: modelo,
                            codigoTabelaReferencia: referencia)

      response.body
    end

    def ano_modelo(tipo_veiculo, marca, modelo, ano_modelo, referencia)
      referencia ||= ultimo_periodo_referencia['Codigo']
      ano, combustivel = ano_modelo.split('-')

      response = @conn.post('/api/veiculos/ConsultarValorComTodosParametros',
                            codigoTipoVeiculo: tipo_veiculo,
                            codigoMarca: marca,
                            codigoModelo: modelo,
                            anoModelo: ano,
                            codigoTipoCombustivel: combustivel,
                            codigoTabelaReferencia: referencia,
                            tipoConsulta: 'tradicional')

      response.body
    end

    private

    def ultimo_periodo_referencia
      time_now = Time.now

      referencias.first do |referencia|
        referencia['Mes'] == "#{MESES[time_now.month]}/#{time_now.year} "
      end
    end
  end
end
