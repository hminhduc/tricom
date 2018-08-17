class AddColToJobuchiwake < ActiveRecord::Migration[5.0]
  def change
    add_column :JOB内訳マスタ, :完了区分, :boolean
  end
end
