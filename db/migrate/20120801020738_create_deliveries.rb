class CreateDeliveries < ActiveRecord::Migration
  def change
    create_table :deliveries do |t|
      t.string :access_code
      t.references :parent
      t.references :message
      t.boolean :success, default: false

      t.timestamps
    end
  end
end
