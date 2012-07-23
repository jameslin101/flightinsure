class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :address_1, :string
    add_column :users, :address_2, :string
    add_column :users, :city, :string
    add_column :users, :state, :string
    add_column :users, :zip_code, :string
    add_column :users, :credit_card_number, :string
    add_column :users, :expiration_month, :string
    add_column :users, :expiration_year, :string
    add_column :users, :card_security_code, :string
  end
end
