class CreateCertifications < ActiveRecord::Migration
  def change
    create_table :certifications do |t|
      t.references :company
      t.references :certificate
    end
  end
end
