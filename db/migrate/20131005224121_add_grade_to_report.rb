class AddGradeToReport < ActiveRecord::Migration
  def change
    add_column :reports, :grade, :string
  end
end
