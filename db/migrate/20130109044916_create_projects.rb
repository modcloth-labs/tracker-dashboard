class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer :tracker_id
      t.integer :credentials_id
      t.string :name
      t.text :all_labels, :default => "", :null => false
      t.text :enabled_labels, :default => "", :null => false
      t.boolean :enabled

      t.timestamps
    end
  end
end
