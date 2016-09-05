class CreateChickoutOrders < ActiveRecord::Migration
  def change
    create_table :chickout_orders do |t|
      t.decimal  :total_price
      t.date     :completed_date
      t.string   :state
      t.string   :next_step
      t.string   :shipping_method
      t.decimal  :shipping_price
      t.decimal  :subtotal
      t.integer  :customer_id
      t.integer  :credit_card_id
      t.integer  :billing_address_id
      t.integer  :shipping_address_id

      t.timestamps null: false
    end

    add_index :chickout_orders, :customer_id
    add_index :chickout_orders, :credit_card_id
    add_index :chickout_orders, :billing_address_id
    add_index :chickout_orders, :shipping_address_id

    add_reference :chickout_orders, :coupon, index: true, foreign_key: true
  end
end