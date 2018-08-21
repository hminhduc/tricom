class ChangeColumnKanryoukubun < ActiveRecord::Migration[5.0]
  def change
  	change_column :JOB内訳マスタ, :完了区分, :boolean, :default => false
  end
end
