class AddDefaultToPostCounter < ActiveRecord::Migration[7.1]
  def change
    change_column :users, :post_counter, :integer, default: 0
  end
end
