class CreateChickoutItems < ActiveRecord::Migration
  def change
    create_table :chickout_items do |t|
      t.decimal  :price
      t.integer  :quantity
      t.integer  :product_id

      t.timestamps null: false
    end
    
    add_index :chickout_items, :product_id
    
    add_reference :chickout_items, :order, index: true, foreign_key: true
  end
end
