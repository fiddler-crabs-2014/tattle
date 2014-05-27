class MainController < ApplicationController
  respond_to :json

  def index
  end

  def search
    respond_to do |format|
      format.html { render :json => ApplicationController.generate_results(params["company"]) }
      format.json { render :json => ApplicationController.generate_results(params["company"]) }
    end
  end

  def children
    freebase = FreebaseService.new
    respond_to do |format|
      format.html { render :json => { children: freebase.get_children_names(freebase.get_children_ids(params["company"]) } }
      format.json { render :json => { children: freebase.get_children_names(freebase.get_children_ids(params["company"]) } }
    end
  end

end
