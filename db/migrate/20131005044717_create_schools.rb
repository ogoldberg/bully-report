class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.integer :external_id
      t.string  :name
      t.string  :grades
      t.string  :address
      t.string  :phone
      t.integer :zip
      t.float   :lat
      t.float   :lng

      t.timestamps
    end

    add_index :schools, :external_id, :unique => true
  end
end