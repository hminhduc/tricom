json.kouteis(@kouteimasters) do |koutei|
  json.extract! koutei, :所属コード, :工程コード, :工程名
end
