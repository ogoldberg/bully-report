class ReportsController < ApplicationController

  def index
    @reports = Report.all.limit(20)
  end

  def show
  end

  def new
    @school = School.find_by_id(params[:school_id])
    @report = Report.new
  end

  def create
    @school = School.find_by_id(params[:school_id])
    @report = Report.create(report_params)
    @report.school = @school
    @report.save()
    @school.num_reports = @school.num_reports.to_i + 1
    @school.save()
    redirect_to '/'
  end

  private

  def report_params
    params.require(:report).permit(:school_id, :type_of_bullying, :person_told, :happened_to)
  end

end
