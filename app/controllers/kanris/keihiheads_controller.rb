class Kanris::KeihiheadsController < ApplicationController
  before_action :require_kanriG_user!
  def index
    if params[:date].present?
      @date = params[:date].to_date
    else
      @date = Date.today.to_date
    end
    @keihiheads = Keihihead.all.where(日付: @date.beginning_of_month..@date.end_of_month )
    if params[:user_name].nil?
      @user_name = current_user.担当者コード
      @keihiheads = @keihiheads.where(社員番号: @user_name)
    end
    if params[:user_name].present?
      @user_name = params[:user_name]
      @keihiheads = @keihiheads.where(社員番号: @user_name)
    end
  end
end
