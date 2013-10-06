class SearchController < ApplicationController
  def index
    lat = params[:lat].to_f
    lng = params[:lng].to_f

    if lat != 0 and lng != 0
      @schools = School.within(4, :origin => [lat, lng]).order("name")
    else
      @schools = School.where('zip = ? OR address ~* ? OR name ~* ?', params[:zip], params[:address], params[:name])  
    end
  end
end
