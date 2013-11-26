# This migration comes from spree_product_assembly (originally 20130614141524)
class AddLineItemIdToSpreeInventoryUnits < ActiveRecord::Migration
  def change
    add_column :spree_inventory_units, :line_item_id, :integer
    add_index :spree_inventory_units, :line_item_id
  end
end
