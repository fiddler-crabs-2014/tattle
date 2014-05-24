class MainController < ApplicationController

  def index
  end

  def search
    respond_to do |format|
      format.json { render :json => ApplicationController.generate_results(params["company_name"]) }
    end
  end

end
