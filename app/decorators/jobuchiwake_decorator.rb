class JobuchiwakeDecorator < Draper::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end
  def jushinnichiji
    jobuchiwake.受付日時&.strftime('%Y/%m/%d %H:%M')
  end

  def jushinshubetsu
    "#{ jobuchiwake.受付種別 } : #{ Jobuchiwake::UKETSUKESHUBETSU[jobuchiwake.受付種別] }"
  end

  def kanryoukubun
    "<span class='glyphicon glyphicon-ok text-success'></span>".html_safe if jobuchiwake.完了区分
  end

  def delete_link
    h.link_to '', jobuchiwake, method: :delete, remote: true, data: { confirm: '削除して宜しいですか？' }, class: 'glyphicon glyphicon-remove text-danger remove-underline'
  end
end
