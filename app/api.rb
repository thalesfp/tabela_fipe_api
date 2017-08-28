# frozen_string_literal: true

require 'grape'

require_relative 'tabela'
require_relative 'veiculo'

module Fipe
  class API < Grape::API
    version 'v1', using: :path
    format :json

    desc 'Retorna os meses de referências'
    get :referencias do
      tabela = Tabela.new
      tabela.referencias
    end

    desc 'Retorna as marcas dos veículos.'
    params do
      requires :tipo_veiculo, type: Veiculo, desc: 'Tipo de veículo'
      optional :referencia, type: Integer, desc: 'Mês de referência do preço'
    end
    get '/:tipo_veiculo/marcas' do
      tabela = Tabela.new
      tabela.marcas(params[:tipo_veiculo].value, params[:referencia])
    end

    desc 'Retorna os modelos da marca.'
    params do
      requires :tipo_veiculo, type: Veiculo, desc: 'Tipo de veículo (carros ou motos)'
      requires :marca, type: Integer, desc: 'Código da marca'
      optional :referencia, type: Integer, desc: 'Mês de referência do preço'
    end
    get '/:tipo_veiculo/marcas/:marca/modelos' do
      tabela = Tabela.new
      tabela.modelos(params[:tipo_veiculo].value, params[:marca], params[:referencia])
    end

    desc 'Retorna os ano modelos de um modelo.'
    params do
      requires :tipo_veiculo, type: Veiculo, desc: 'Tipo de veículo (carros ou motos)'
      requires :marca, type: Integer, desc: 'Código da marca'
      requires :modelo, type: Integer, desc: 'Código do modelo'
      optional :referencia, type: Integer, desc: 'Mês de referência do preço'
    end
    get '/:tipo_veiculo/marcas/:marca/modelos/:modelo/ano_modelos' do
      tabela = Tabela.new
      tabela.ano_modelos(params[:tipo_veiculo].value, params[:marca], params[:modelo], params[:referencia])
    end

    desc 'Retorna informações sobre o ano modelo.'
    params do
      requires :tipo_veiculo, type: Veiculo, desc: 'Tipo de veículo (carros ou motos)'
      requires :marca, type: Integer, desc: 'Código da marca'
      requires :modelo, type: Integer, desc: 'Código do modelo'
      requires :ano_modelo, type: String, desc: 'Código do ano modelo'
      optional :referencia, type: Integer, desc: 'Mês de referência do preço'
    end
    get '/:tipo_veiculo/marcas/:marca/modelos/:modelo/ano_modelos/:ano_modelo' do
      tabela = Tabela.new
      tabela.ano_modelo(params[:tipo_veiculo].value, params[:marca], params[:modelo], params[:ano_modelo], params[:referencia])
    end

    desc 'Retorna informações sobre o ano modelo a partir do código Fipe.'
    params do
      requires :tipo_veiculo, type: Veiculo, desc: 'Tipo de veículo (carros ou motos)'
      requires :codigo_fipe, type: String, desc: 'Código de referência da tabela Fipe'
      requires :ano_modelo, type: String, desc: 'Código do ano modelo'
      optional :referencia, type: Integer, desc: 'Mês de referência do preço'
    end
    get '/:tipo_veiculo/codigo_fipe/:codigo_fipe/ano_modelos/:ano_modelo' do
      tabela = Tabela.new
      tabela.codigo_fipe(params[:tipo_veiculo].value, params[:codigo_fipe], params[:ano_modelo], params[:referencia])
    end
  end
end
