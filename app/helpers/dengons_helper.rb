module DengonsHelper
  def update_dengon_counter shainbango
    counter = Dengon.where(社員番号: shainbango, 確認: false).count
    Shainmaster.find(shainbango).update(伝言件数: counter)
  end

  def update_dengon_counter_with_id shainbango
    if !shainbango.nil? && shainbango!=''
      counter = Dengon.where(社員番号: shainbango, 確認: false).count
      Shainmaster.find(shainbango).update(伝言件数: counter)
    end
  end

  def send_mail(to_mail, subject_mail, body_mail)
    Mail.deliver do
      to to_mail
      from 'skybord@jpt.co.jp'
      subject subject_mail
      body body_mail
    end
  end
end
