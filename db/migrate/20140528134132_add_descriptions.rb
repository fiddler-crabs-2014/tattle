class AddDescriptions < ActiveRecord::Migration
  def change
  	add_column :certificates, :description, :text
  end
end
