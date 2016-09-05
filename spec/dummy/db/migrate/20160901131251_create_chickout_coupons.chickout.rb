# This migration comes from chickout (originally 20160829065844)
class CreateChickoutCoupons < ActiveRecord::Migration
  def change
    create_table :chickout_coupons do |t|
      t.string   :code
      t.integer  :discount

      t.timestamps null: false
    end
  end
end
