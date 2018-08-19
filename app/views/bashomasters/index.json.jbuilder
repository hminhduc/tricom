json.bashos(@bashomasters) do |basho|
  json.extract! basho, :場所コード, :場所名, :場所名カナ, :場所区分, :会社コード
end
