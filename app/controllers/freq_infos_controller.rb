class FreqInfosController < ApplicationController
  before_action :authenticate_user!

  def create
    @page = Page.find(params[:page_id])
    freq_info = @page.freq_infos.build(freq_info_params)
    if freq_info.save
      flash[:notice] = "information saved"
      redirect_to @page
    else
      flash[:alert] = "Infomation could not be saved"
      render 'pages/show'
    end
  end

  private

  def freq_info_params
    params.require(:freq_info).permit(:content).merge!(user: current_user)
  end
end
