class AddDefaultToPostCount < ActiveRecord::Migration[7.0]
  def change
    change_column_default :users, :post_count, 0
  end
end
