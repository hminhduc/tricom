class CreateHikiaijobmasters < ActiveRecord::Migration[5.0]
  def change
    create_table :JOB引合マスタ do |t|
      t.string :job番号
      t.string :job名
      t.date :開始日
      t.date :終了日
      t.string :ユーザ番号
      t.string :ユーザ名
      t.string :紹介元名
      t.string :入力社員番号
      t.string :備考

      t.timestamps
    end

    add_index :JOB引合マスタ, :job番号, unique: true
  end
end
