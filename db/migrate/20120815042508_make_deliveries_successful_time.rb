class MakeDeliveriesSuccessfulTime < ActiveRecord::Migration
  def change
    add_column :deliveries, :delivered_at, :datetime
    remove_column :deliveries, :success
  end
end
