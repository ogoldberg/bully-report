class AddPersonToldToReport < ActiveRecord::Migration
  def change
    add_column :reports, :person_told, :string
  end
end
