class MapController < ApplicationController

  def index
  end

  def search
    lat = params[:latitude].to_f
    lng = params[:longitude].to_f

    if lat == 0 or lng == 0
      return redirect_to "/map"
    end

    schools = School.within(4, :origin => [lat, lng]).load()

    respond_to do |format|
      format.html { render :json => schools }
      format.json { render :json => schools }
    end
  end

end
