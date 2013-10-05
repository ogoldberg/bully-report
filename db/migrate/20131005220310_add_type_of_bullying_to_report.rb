class AddTypeOfBullyingToReport < ActiveRecord::Migration
  def change
    add_column :reports, :type_of_bullying, :string
  end
end
