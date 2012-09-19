class RenameDeliveriesDeliveredAtToCheckedAt < ActiveRecord::Migration
  def change
    rename_column :deliveries, :delivered_at, :checked_at
  end
end
