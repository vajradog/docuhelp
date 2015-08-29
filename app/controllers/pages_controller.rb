class PagesController < ApplicationController
  before_filter :set_page, only: [:show, :edit, :update, :destroy]

  def index
    @pages = Page.all
    @search_results = Page.text_search(params[:query])
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
    @pages = Page.all
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


  private

  def set_page
    @page = Page.find(params[:id])
  end

  def page_params
    params.require(:page).permit(:title, :content, :parent_id)
  end
end
