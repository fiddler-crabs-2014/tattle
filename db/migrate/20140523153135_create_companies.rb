class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.references :industry
      t.text :result_json
      t.timestamps
    end
  end
end
