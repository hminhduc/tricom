class AddColToTables < ActiveRecord::Migration[5.0]
  def change
    add_column :JOBマスタ, :JOB内訳区分, :string
    add_column :events, :JOB内訳番, :string
    add_column :events, :作業区分, :string
  end
end
