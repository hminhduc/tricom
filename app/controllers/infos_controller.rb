class InfosController < ApplicationController
  before_action :set_info, only: [:show, :edit, :update, :destroy]

  respond_to :html, :json

  def index
    @keyword1 = params[:search_unfinish] #you can get this params from the value of the search form input
    if @keyword1.present?
      @infos1 = Info.where("done = 0 AND (title LIKE (?) OR description LIKE (?))", "%#{@keyword1}%","%#{@keyword1}%").order(id: :desc)
    else
      @infos1 = Info.where(done: 0).order(id: :desc)
    end

    @keyword2 = params[:search_finish]
    if @keyword2.present?
      @infos2 = Info.where("done = 1 AND (title LIKE (?) OR description LIKE (?))", "%#{@keyword2}%","%#{@keyword2}%").order(updated_at: :desc)
    else
      @infos2 = Info.where(done: 1).order(updated_at: :desc)
    end
  end

  def show
    respond_with(@info)
  end

  def new
    @info = Info.new
  end

  def edit
    respond_with(@info, location: infos_url)
  end

  def create
    @info = Info.new(info_params)
    respond_to do |format|
      if @info.save
        format.js { render 'create_info' }
      else
        format.js { render json: @info.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @info.update(info_params)
    respond_with(@info, location: infos_url)
  end

  def destroy
    @info.destroy
    respond_with(@info)
  end

  def sort
    params[:order].each do |key, value|
      Info.find(value[:id]).update_attribute(:priority, value[:position])
    end
    render nothing: true
  end

  def change_status
    @info = Info.find(params[:id])
    if params[:decision] == 'true'
      @info.update(done: 1)
      respond_with(@info, location: infos_url)
    elsif params[:decision] == 'false'
      @info.update(done: 0)
      respond_with(@info, location: infos_url)
    end
  end

  def ajax
    case params[:focus_field]
    when 'info_削除する'
      info = Info.find(params[:info_id])
      info.destroy if info

      data = { destroy_success: 'success' }
      respond_to do |format|
        format.json { render json: data }
      end
    when 'change_status'
      @info = Info.find(params[:info_id])
      if @info.done == 0
        @info.update(done: 1)
      elsif @info.done == 1
        @info.update(done: 0)
      end

      respond_to do |format|
        format.js { render 'change_status' }
      end
    when 'info_create'
      @info = Info.new(title: 'タイトル')
      respond_to do |format|
        if @info.save
          format.js { render 'create_info' }
        else
          format.js { render json: @info.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def search
    keyword = params[:search_unfinish] #you can get this params from the value of the search form input
    @infos = Info.where("title LIKE ?", "%#{keyword}%")
  end

  private

  def set_info
    @info = Info.find(params[:id])
  end

  def info_params
    params.require(:info).permit(:title, :description, :priority, :done)
  end
end
