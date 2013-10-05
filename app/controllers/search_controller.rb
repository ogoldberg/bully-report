class SearchController < ApplicationController
  def index
    @schools = School.where('zip = ? OR address ilike ? OR name ilike ? OR (lat = ? AND lng = ?)', params[:zip], '%#{search}%', '%#{search}%', params[:lat], params[:lng])  
  end
end
