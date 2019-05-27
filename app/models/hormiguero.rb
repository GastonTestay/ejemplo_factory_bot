class Hormiguero < ApplicationRecord

  has_many :hormigas
  belongs_to :ubicacion, class_name: :Punto

  after_initialize :inicializar

  def inicializar
    self.alimento_recolectado = 0
  end

  def agregar(una_hormiga)
    hormigas << una_hormiga
    save
  end

  def cantidad_de_hormigas
    hormigas.size
  end

  def cantidad_de_hormigas_al_limite
    hormigas_al_limite.count
  end

  def llamar_hormigas_a_depositar_alimento
    hormigas.each do |hormiga|
      hormiga.es_llamada_para_ir_a_depositar_en self
    end

  end

  def agregar_alimento(unos_gramos)
    self.alimento_recolectado += unos_gramos
  end

  def hormigas_al_limite
    hormigas.select(&:esta_al_limite?)
  end
end
