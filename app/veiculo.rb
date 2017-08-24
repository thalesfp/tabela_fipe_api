# frozen_string_literal: true

class Veiculo
  attr_reader :value

  def initialize(veiculo)
    @value = veiculo
  end

  def self.parse(value)
    if value == 'carros'
      new(1)
    elsif value == 'motos'
      new(2)
    else
      raise 'Veículo inválido'
    end
  end
end
