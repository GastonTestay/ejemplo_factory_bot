require 'rails_helper'
require_relative '../../app/models/Alimento'

RSpec.describe Hormiga, type: :model do
  let(:diez_gramos) {10}
  let(:una_posicion) {Punto.create(x: 2, y: 2)}
  let(:origen) {Punto.create(x: 0, y: 0)}

  def crear_alimento(unos_gramos)
    Alimento.con gramos: unos_gramos, ubicacion: una_posicion
  end

  describe 'una hormiga' do
    let(:cero_gramos) {0}

    let(:una_hormiga) {Hormiga.create(ubicacion: origen)}

    it 'inicialmente esta sin carga' do
      expect(una_hormiga.alimento_recolectado).to eq(cero_gramos)
    end

    it 'puede cambiar de ubicacion' do
      una_hormiga.moverse_a(una_posicion)

      expect(una_hormiga.esta_en?(una_posicion)).to be(true)
      expect(una_hormiga.esta_en?(origen)).to be(false)
    end

    describe 'cuando realiza carga de alimentos' do
      let(:tres_gramos) {3}

      let(:once_gramos) {11}

      it 'se mueve hasta el lugar del alimento' do
        un_alimento = crear_alimento(tres_gramos)

        una_hormiga.recolectar_de un_alimento

        expect(una_hormiga.esta_en?(un_alimento.ubicacion)).to be_truthy
      end

      context 'si no esta al limite' do
        it 'recolecta alimento menor al limite, sigue sin estar al limite' do
          un_alimento = crear_alimento(tres_gramos)

          una_hormiga.recolectar_de un_alimento

          expect(una_hormiga.alimento_recolectado).to eq(tres_gramos)
          expect(una_hormiga.esta_al_limite?).to be_falsey
        end

        it 'recolecta alimento mayor al limite entonces esta al limite' do
          un_alimento = crear_alimento(once_gramos)

          una_hormiga.recolectar_de un_alimento

          expect(una_hormiga.alimento_recolectado).to eq(diez_gramos)
          expect(una_hormiga.esta_al_limite?).to be_truthy
        end

        it 'recolecta alimento igual al limite entonces esta al limite' do
          un_alimento = crear_alimento(diez_gramos)

          una_hormiga.recolectar_de un_alimento

          expect(una_hormiga.alimento_recolectado).to eq(diez_gramos)
          expect(una_hormiga.esta_al_limite?).to be_truthy
        end
      end

      context 'si esta al limite' do
        before do
          una_hormiga.recolectar_de crear_alimento(diez_gramos)
        end

        it 'no carga mas' do
          un_alimento = crear_alimento(tres_gramos)

          una_hormiga.recolectar_de un_alimento

          expect(una_hormiga.alimento_recolectado).to eq(diez_gramos)
        end
      end
    end

    describe 'cuando es llamada a descargar' do
      let(:un_hormiguero) {Hormiguero.create(ubicacion: origen)}

      context 'estando al limite' do
        before do
          un_alimento = crear_alimento(diez_gramos)
          una_hormiga.recolectar_de un_alimento
        end
        it 'se mueve hasta el hormiguero' do
          una_hormiga.es_llamada_para_ir_a_depositar_en un_hormiguero

          expect(una_hormiga.esta_en? un_hormiguero.ubicacion).to be_truthy
        end

        it 'descarga toda la comida acumulada' do
          una_hormiga.es_llamada_para_ir_a_depositar_en un_hormiguero

          expect(una_hormiga.alimento_recolectado).to eq(cero_gramos)
        end
      end

    end

  end
end
