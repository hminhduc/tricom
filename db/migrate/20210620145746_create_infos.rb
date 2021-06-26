class CreateInfos < ActiveRecord::Migration[5.0]
  def change
    create_table :infos do |t|
      t.string :title
      t.string :description
      t.integer :priority
      t.integer :done, :default => 0

      t.timestamps
    end
  end
end
