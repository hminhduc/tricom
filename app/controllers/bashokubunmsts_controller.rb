class BashokubunmstsController < ApplicationController
  before_action :require_user!
  respond_to :html, :js

  def index
    @bashokubunmsts = Bashokubunmst.all
    respond_with(@bashokubunmsts)
  end

  def create
    @bashokubunmst = Bashokubunmst.new(bashokubunmst_params)
    flash[:notice] = t 'app.flash.new_success' if @bashokubunmst.save
    render 'share/create', locals: { obj: @bashokubunmst, table_id: 'bashokubunmst_table', attr_list: Bashokubunmst::SHOW_ATTRS }
  end

  def update
    @bashokubunmst = Bashokubunmst.find_by(場所区分コード: bashokubunmst_params[:場所区分コード])
    flash[:notice] = t 'app.flash.update_success' if @bashokubunmst&.update(bashokubunmst_params)
    render 'share/update', locals: { obj: @bashokubunmst, table_id: 'bashokubunmst_table', attr_list: Bashokubunmst::SHOW_ATTRS }
  end

  def destroy
    if params[:ids]
      Bashokubunmst.where(場所区分コード: params[:ids]).destroy_all
      data = { destroy_success: 'success' }
      respond_to do |format|
        format.json { render json: data }
      end
    else
      @bashokubunmst = Bashokubunmst.find_by(場所区分コード: params[:id])
      @bashokubunmst.destroy if @bashokubunmst
      render 'share/destroy', locals: { obj: @bashokubunmst, table_id: 'bashokubunmst_table' }
    end
  end

  def import
    super(Bashokubunmst, bashokubunmsts_path)
  end

  def export_csv
    @bashokubunmsts = Bashokubunmst.all
    respond_to do |format|
      format.csv { send_data @bashokubunmsts.to_csv, filename: '場所区分マスタ.csv' }
    end
  end

  private

    def bashokubunmst_params
      params.require(:bashokubunmst).permit(:場所区分コード, :場所区分名)
    end
end
