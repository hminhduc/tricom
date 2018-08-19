json.jobuchiwakes(@jobuchiwakes) do |jobuchiwake|
  json.extract! jobuchiwake, :ジョブ番号, :ジョブ内訳番号, :件名, :完了区分
  json.受付日時 jobuchiwake.jushinnichiji
  json.受付種別 jobuchiwake.jushinshubetsu
end
