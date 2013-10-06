class ReportsController < ApplicationController

  def index
    @index = Report.all.limit(20)
  end

  def show
  end

  def new
    @school = School.find_by_id(params[:id])
    @report = Report.new
  end

  def create
    @school = School.find_by_id(params[:id])
    @report = Report.create(params[:report])
  end

end
