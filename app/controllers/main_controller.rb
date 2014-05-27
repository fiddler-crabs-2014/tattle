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
  end

end
