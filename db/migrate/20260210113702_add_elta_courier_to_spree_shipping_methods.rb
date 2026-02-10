class AddEltaCourierToSpreeShippingMethods < ActiveRecord::Migration[8.1]
  def change
    add_column :spree_shipping_methods, :elta_courier, :boolean
  end
end
