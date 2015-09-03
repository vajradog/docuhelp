class VersionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_page_and_version, only: [:diff, :rollback, :destroy]

  def diff
  end

  def rollback
    # change the current document to the specified version
    # reify gives you the object of this version
    page = @version.reify
    page.save
    redirect_to edit_page_path(page)
  end

  def bringback
    version = PageVersion.find(params[:id])
    @page = version.reify
    @page.save
    # Let's remove the version since the document is undeleted
    version.delete
    redirect_to root_path, notice: 'The page was successfully brought back!'
  end


  private

  def set_page_and_version
    @page = Page.friendly.find(params[:page_id])
    @version = @page.versions.find(params[:id])
  end

end
