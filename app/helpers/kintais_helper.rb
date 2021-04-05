module KintaisHelper
  def place_holder_list_1
    [
      "<i class='fa fa-sort-desc'></i>",
      '&nbsp;', '&nbsp;', '&nbsp;', '&nbsp;', '&nbsp;', '&nbsp;', '&nbsp;', '&nbsp;',
      "<i class='fa fa-sort-desc'></i>",
      "<i class='fa fa-sort-desc'></i>",
      '&nbsp;'
    ]
  end

  def place_holder_list_2
    [
      "<span class='text-gray'>タイプ</span>",
      "<span class='text-gray'>出勤時間</span>",
      "<span class='text-gray'>退社時間</span>",
      "<span class='text-gray'>実労働時間</span>",
      "<span class='text-gray'>遅刻早退</span>",
      "<span class='text-gray'>普通残業</span>",
      "<span class='text-gray'>深夜残業</span>",
      "<span class='text-gray'>0.0</span>",
      "<span class='text-gray'>0.0</span>",
      "<span class='text-gray'></span>",
      "<span class='text-gray'></span>",
      "<span class='text-gray'>時間内残業</span>"
    ]
  end

  def joutais
    Joutaimaster.active(['1', '2', '5', '6']).order('CAST(状態コード AS DECIMAL) asc').pluck(:状態コード, :状態名).insert(0, ['', ''])
  end
end
