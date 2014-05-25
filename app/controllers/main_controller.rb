class MainController < ApplicationController
  respond_to :json

  def index
    # @certificates = Certificate.all
    # @companies = Company.all
    # respond_with @certificates
  end

  def search
    puts "INSIDE SEARCH ---- PARAMS: #{params.inspect}"
    respond_to do |format|
      format.html { render :json => ApplicationController.generate_results(params["company"]) }
      format.json { render :json => ApplicationController.generate_results(params["company"]) }
    end
  end

end
