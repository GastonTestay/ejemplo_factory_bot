class AddReferenceUbicacionEnHormiguero < ActiveRecord::Migration[5.2]
  def change
    add_reference :hormigueros, :ubicacion, references: :punto, index: true
  end
end
