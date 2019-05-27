# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Hormiguero, type: :model do
  let(:origen) { Punto.create(x: 0, y: 0) }
  let(:hormiguero) { Hormiguero.create(ubicacion: origen) }
  let(:una_hormiga) { Hormiga.create(ubicacion: origen) }
  let(:otra_hormiga) { Hormiga.create(ubicacion: origen) }
  let(:diez_gramos) { 10 }
  let(:cero_gramos) { 0 }

  context 'un hormiguero nuevo' do
    context 'no tiene hormigas' do
      it 'sin hormigas :P' do
        expect(hormiguero.cantidad_de_hormigas).to eq(0)
      end

      it 'que esten al limite' do
        expect(hormiguero.cantidad_de_hormigas_al_limite).to eq(0)
      end

      it 'su alimento recolectado es de 0 gramos' do
        expect(hormiguero.alimento_recolectado).to eq(cero_gramos)
      end
    end

    it 'agrega una hormiga' do
      hormiguero.agregar una_hormiga

      expect(hormiguero.cantidad_de_hormigas).to eq(1)
    end
  end

  context 'con una hormiga' do
    let(:alimento_con_diez_gramos) { Alimento.con gramos: diez_gramos, ubicacion: origen }

    before do
      hormiguero.agregar una_hormiga
    end

    it 'tiene una hormiga que esta al limite' do
      una_hormiga.recolectar_de alimento_con_diez_gramos

      expect(hormiguero.cantidad_de_hormigas_al_limite).to eq(1)
    end

    context 'pide que las hormigas dejen el alimento recolectado' do
      it 'una hormiga que no esta limite no es llamada a depositar' do
        alimento_con_ocho_gramos = Alimento.con(gramos: 8, ubicacion: origen)
        una_hormiga.recolectar_de alimento_con_ocho_gramos

        hormiguero.llamar_hormigas_a_depositar_alimento

        expect(hormiguero.alimento_recolectado).to eq(cero_gramos)
      end

      it 'una hormiga al limite si es llamada a depositar' do
        una_hormiga.recolectar_de alimento_con_diez_gramos

        hormiguero.llamar_hormigas_a_depositar_alimento

        expect(hormiguero.alimento_recolectado).to eq(10)
      end
    end
  end
end
