class MainController < ApplicationController
  respond_to :json

  def index
    @certificates = Certificate.all
    @companies = Company.all
    respond_with @certificates
  end

  def search
    respond_to do |format|
      format.json { render :json => ApplicationController.generate_results(params["company_name"]) }
    end
  end

end
