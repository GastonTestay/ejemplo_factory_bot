class AddReferencePuntoEnHormiga < ActiveRecord::Migration[5.2]
  def change
    add_reference :hormigas, :ubicacion, references: :punto, index: true
  end
end
