class AddHappenedToToReports < ActiveRecord::Migration
  def change
    add_column :reports, :happened_to, :string
  end
end
