# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Punto, type: :model do

  describe 'punto' do

    context 'comparacion entre dos puntos' do

      it 'es distinto si el eje Y no es el mismo' do
        origen = Punto.create!(x: 0, y: 0)
        otroPunto = Punto.create!(x: 0, y: 1)

        expect(origen.es_igual?(otroPunto)).to be(false)
      end

      it 'es distinto si el eje X no es el mismo' do
        origen = Punto.create!(x: 0, y: 0)
        otroPunto = Punto.create!(x: 1, y: 0)

        expect(origen.es_igual?(otroPunto)).to be(false)
      end

      it 'la igualdad entre dos puntos es que sus ejes sean iguales' do
        origen = Punto.create!(x: 0, y: 0)
        otroPunto = Punto.create!(x: 0, y: 0)

        expect(origen.es_igual?(otroPunto)).to be(true)
      end
    end
  end
end
