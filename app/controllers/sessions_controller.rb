class SessionsController < ApplicationController
  before_action :check_login, only: [:new, :create]
  require 'mail'
  def new
  end

  def send_mail
  end

  def confirm_mail
    user = User.find_by(担当者コード: params[:session][:担当者コード], email: params[:session][:email])

    if user
      session[:code] = random_string
      session[:user_code] = user.try(:担当者コード)
      if user.update(password:  session[:code], flag_reset_password: true)
        Mail.deliver do
          to "#{user.try(:email)}"
          from 'skybord@jpt.co.jp'
          subject '【勤務システム】'
          body "担当者コード : 【#{user.try(:担当者コード)}】。新しいパスワード: 【#{ session[:code]}】。"
        end
        flash[:notice] = t 'app.login.send_mail'
        redirect_to login_path
      else
        flash[:danger] = t 'app.flash.login_field'
        render 'send_mail'
      end

    else
      flash[:danger] = t 'app.flash.login_field'
      render 'send_mail'
    end
  end

  def random_string(length = 8)
    rand(32**length).to_s(32)
  end

  def login_code
  end
  def login_code_confirm
    user = User.find_by(担当者コード: params[:session][:担当者コード])
    if user && !session[:code].nil? && params[:session][:code] == session[:code] && !session[:user_code].nil? && params[:session][:担当者コード] == session[:user_code]
      flash[:notice] = t 'app.flash.wellcome_to'
      log_in user
    else
      flash[:danger] = t 'app.flash.login_field'
      render 'login_code'
    end
  end

  def create
    if request.headers['Connect-Type'] == 'api'
      authenticate_user
    else
      user = User.find_by 担当者コード: params[:session][:担当者コード]
      if user && (user.authenticate params[:session][:password])
        respond_to do |f|
          f.html do
            flash[:notice] = t 'app.flash.wellcome_to'
            log_in user
            respond_with user, location: time_line_view_events_url
          end
          f.json do
            log_in user
            render json: { message: t('app.flash.wellcome_to') }, status: :ok
          end
        end
      else
        respond_to do |f|
          f.html do
            flash[:danger] = t 'app.flash.login_field'
            render 'new'
          end
          f.json { render json: { message: t('app.flash.login_field') }, status: 404 }
        end
      end
    end
  end

  def destroy
    log_out if logged_in?
    respond_to do |f|
      f.html { redirect_to root_path }
      f.json
    end
  end

  private
    def check_login
      if logged_in?
        flash[:notice] = t 'app.login.logged_in'
        redirect_to main_path
      end
    end

    def authenticate_user
      user = User.find_by(担当者コード: params[:担当者コード])
      if user&.authenticate(params[:password])
        render json: payload(user)
      else
        render json: { errors: ['Invalid Username/Password'] }, status: :unauthorized
      end
    end

    def payload(user)
      return nil unless user&.id
      {
        auth_token: JsonWebToken.encode(user_id: user.id),
        user: { id: user.id, 担当者コード: user.担当者コード }
      }
    end
end
