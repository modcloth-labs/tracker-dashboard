class AddVelocityToProject < ActiveRecord::Migration
  def change
    add_column :projects, :current_velocity, :integer
  end
end
