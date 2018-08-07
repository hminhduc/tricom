class CreateSagyoukubuns < ActiveRecord::Migration[5.0]
  def change
    create_table :作業区分内訳 do |t|
      t.string :作業区分
      t.string :作業区分名称

      t.timestamps
    end
  end
end
