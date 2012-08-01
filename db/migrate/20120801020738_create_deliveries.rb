class CreateDeliveries < ActiveRecord::Migration
  def change
    create_table :deliveries do |t|
      t.references :parent
      t.references :message
      t.boolean :read, default: false

      t.timestamps
    end
  end
end
