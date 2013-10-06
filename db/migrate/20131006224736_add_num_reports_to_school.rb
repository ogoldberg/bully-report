class AddNumReportsToSchool < ActiveRecord::Migration
  def change
    add_column :schools, :num_reports, :integer
  end
end
