class AddRatingToReport < ActiveRecord::Migration
  def change
    add_column :reports, :rating, :string
  end
end
