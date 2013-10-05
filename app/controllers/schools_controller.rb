class SchoolsController < ApplicationController
  def index
    @schools = School.all
  end

  def show
    @school = School.find_by_id(params[:id])
  end
end
