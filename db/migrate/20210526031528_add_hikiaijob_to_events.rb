class AddHikiaijobToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :JOBマスタ, :JOB引合区分, :boolean
    add_column :events, :JOB引合, :string
  end
end
