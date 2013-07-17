class AddAutoRefreshToCredentials < ActiveRecord::Migration
  def change
    add_column :credentials, :reload_data_mins, :integer, :null => false, :default => 60
    add_column :credentials, :data_last_reloaded, :datetime
  end
end
