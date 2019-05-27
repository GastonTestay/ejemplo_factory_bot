# frozen_string_literal: true

class Punto < ApplicationRecord

  def es_igual?(otro_punto)
    (x.equal? otro_punto.x) && (y.equal? otro_punto.y)
  end
end
