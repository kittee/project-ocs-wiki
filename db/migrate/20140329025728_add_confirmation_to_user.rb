class AddConfirmationToUser < ActiveRecord::Migration
  def change
    add_column :users, :confirmed, :boolean
    add_column :users, :confirm_key, :string
  end
end
