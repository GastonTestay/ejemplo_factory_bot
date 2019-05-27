class Alimento

  def self.con(gramos:, ubicacion:)

    if (gramos > 0)
      new(gramos: gramos, ubicacion: ubicacion)
    else
      raise self.mensaje_de_error_los_gramos_deben_ser_mayor_a_0
    end
  end

  def initialize(gramos:, ubicacion:)
    @gramos = gramos
    @ubicacion = ubicacion
  end

  def ubicacion
    @ubicacion
  end

  def cantidad
    @gramos
  end

  def self.mensaje_de_error_los_gramos_deben_ser_mayor_a_0
    'la cantidad de gramos tienen que ser mayor a 0'
  end

  def extraer(una_cantidad_de_gramos)

    cantidad_extraida = cantidad_a_extraer(una_cantidad_de_gramos)

    realizar_extraccion cantidad_extraida

    cantidad_extraida
  end

  private

  def cantidad_a_extraer(una_cantidad_de_gramos)
    una_cantidad_de_gramos <= self.cantidad ? una_cantidad_de_gramos : cantidad
  end

  def realizar_extraccion(una_cantidad_de_gramos)
    @gramos -= una_cantidad_de_gramos
  end

end
