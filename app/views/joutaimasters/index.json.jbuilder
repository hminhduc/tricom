json.joutais(@joutaimasters) do |joutaimaster|
  json.extract! joutaimaster, :状態コード, :状態名, :状態区分, :勤怠状態名, :マーク, :色, :文字色, :WEB使用区分, :勤怠使用区分, :残業計算外区分
end
