class Hormiga < ApplicationRecord

  belongs_to :ubicacion, class_name: :Punto

  after_initialize :inicializar

  def inicializar
    self.alimento_recolectado = 0
  end

  def moverse_a(un_punto)
    self.ubicacion = un_punto
  end

  def esta_al_limite?
    alimento_recolectado >= limite_de_carga
  end

  def recolectar_de(un_alimento)
    moverse_a un_alimento.ubicacion
    realizar_extraccion_de un_alimento
  end

  def esta_en?(una_ubicacion)
    ubicacion.es_igual? una_ubicacion
  end

  def es_llamada_para_ir_a_depositar_en(un_hormiguero)
    if esta_al_limite?
      self.moverse_a(un_hormiguero.ubicacion)
      self.soltar_carga_en(un_hormiguero)
    end
  end

  def soltar_carga_en(un_hormiguero)
    un_hormiguero.agregar_alimento(self.alimento_recolectado)
    self.soltar_carga
  end

  def soltar_carga
    self.alimento_recolectado = 0
  end

  def limite_de_carga
    10
  end

  def cantidad_posible_de_extraccion
    limite_de_carga - alimento_recolectado
  end

  private

  def realizar_extraccion_de(un_alimento)
    cantidad_recolectada = un_alimento.extraer (self.cantidad_posible_de_extraccion)
    self.alimento_recolectado += cantidad_recolectada
  end
end
