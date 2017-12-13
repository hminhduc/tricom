class AddTurningDataAllToSetting < ActiveRecord::Migration[5.0]
  def change
  	add_column :setting_tables, :turning_data_all, :boolean
  end
end
