class AddTrackingUrlToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :tracking_url, :string
  end
end
