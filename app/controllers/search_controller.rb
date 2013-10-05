class SearchController < ApplicationController
  def index
    @schools = School.where('zip = ? OR address ~* ? OR name ~* ? OR (lat = ? AND lng = ?)', params[:zip], params[:address], params[:name], params[:lat], params[:lng])  
  end
end
