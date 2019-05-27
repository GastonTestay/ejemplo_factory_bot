# frozen_string_literal: true

require 'rails_helper'
require_relative '../../app/models/Alimento'

RSpec.describe Alimento, type: :model do
  let(:origen) { Punto.create(x: 0, y: 0) }

  it 'no puede crearse con menos de 0 gramos' do
    expect { Alimento.con gramos: 0, ubicacion: origen }
      .to raise_error(Alimento.mensaje_de_error_los_gramos_deben_ser_mayor_a_0)
  end

  context 'al extraer alimento' do
    let(:un_alimento) { Alimento.con gramos: unos_gramos, ubicacion: origen }

    context 'si la cantidad es mayor a la pedida ' do
      let(:unos_gramos) { 100 }

      it 'el alimento reduce la cantidad pedida ' do
        diez_gramos = 10

        cantidad_extraida = un_alimento.extraer diez_gramos

        expect(cantidad_extraida).to eq diez_gramos
        expect(un_alimento.cantidad).to eq(90)
      end
    end

    context 'si no hay cantidad de sobra de alimento' do
      let(:unos_gramos) { 10 }

      it 'extrae la cantidad que le queda' do
        cien_gramos = 100

        cantidad_extraida = un_alimento.extraer cien_gramos

        expect(cantidad_extraida).to eq unos_gramos
        expect(un_alimento.cantidad).to eq(0)
      end
    end
  end
end
