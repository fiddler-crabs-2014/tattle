class MainController < ApplicationController
  respond_to :json

  def index
  end

  def search
    respond_to do |format|
      format.html { render :json => generate_results(params["company"]) }
      format.json { render :json => generate_results(params["company"]) }
    end
  end

  def children
    freebase = FreebaseService.new
    respond_to do |format|
      format.json { render :json => { children: freebase.children(params["company"]) } }
      format.json { render :json => { children: freebase.children(params["company"]) } }
    end
  end

end
