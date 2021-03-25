class AddJikannaizangyouToKintais < ActiveRecord::Migration[5.0]
  def change
    add_column :kintais, :時間内残業, :decimal
  end
end
