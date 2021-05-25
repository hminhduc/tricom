json.jobs(@jobmasters) do |jobmaster|
  json.extract! jobmaster, :job番号, :job名, :開始日, :終了日, :ユーザ番号, :ユーザ名, :入力社員番号, :備考
end
