class CreateJobuchiwakes < ActiveRecord::Migration[5.0]
  def change
    create_table :JOB内訳マスタ do |t|
      t.string :ジョブ番号
      t.string :ジョブ内訳番号
      t.datetime :受付日時
      t.string :件名
      t.string :受付種別

      t.timestamps
    end
  end
end
