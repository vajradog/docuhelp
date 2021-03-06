class PagesController < ApplicationController
  before_action :authenticate_user!#, #except: [:show, :index]
  before_filter :set_page, only: [:show, :edit, :update, :destroy]

  def index
    @pages = Page.order("created_at desc").page(params[:page]).per_page(5)
    @search_results = Page.text_search(params[:query])
    @activities =  PublicActivity::Activity.order("created_at desc").limit(10)

    if params[:query]
      @queries = params[:query].split(' ')
    end
  end

  def new
    @page = Page.new
  end

  def create
    @page = Page.new(page_params)
    @page.user = current_user
    if @page.save
      flash[:notice] = "Page saved"
      redirect_to pages_path
    else
      flash[:alert] = "Page not saved"
      render :new
    end
  end

  def edit; end

  def show
    if request.path != page_path(@page)
      redirect_to @page, status: :moved_permanently
    end
    @pages = Page.all
    @freq_infos = @page.freq_infos.all.order("created_at desc")
    #@freq_info = @page.freq_infos.build
  end

  def update

    if @page.update(page_params)
      flash[:notice] = "Page updated"
      redirect_to @page
    else
      flash[:notice] = "Page was NOT updated"
      render :edit
    end
  end

  def destroy
    @page.destroy
    flash[:notice] = "Page deleted"
    redirect_to pages_path
  end

  def deleted
    @pages = PageVersion.where(event: 'destroy')
  end


  private

  def set_page
    @page = Page.friendly.find(params[:id])
  end

  def page_params
    params.require(:page).permit(:title, :content, :parent_id)
  end
end
