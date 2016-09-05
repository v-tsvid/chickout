class CreateProdukts < ActiveRecord::Migration
  def change
    create_table :produkts do |t|
      t.string :title
      t.decimal :price

      t.timestamps null: false
    end
  end
end
