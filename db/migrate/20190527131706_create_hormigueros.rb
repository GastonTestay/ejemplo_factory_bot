class CreateHormigueros < ActiveRecord::Migration[5.2]
  def change
    create_table :hormigueros do |t|
      t.integer :alimento_recolectado
      t.timestamps
    end
  end
end
