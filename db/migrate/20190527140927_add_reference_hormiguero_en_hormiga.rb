class AddReferenceHormigueroEnHormiga < ActiveRecord::Migration[5.2]
  def change

    add_reference :hormigas, :hormiguero
  end
end
