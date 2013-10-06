class ReportsController < ApplicationController

  def index
    @reports = Report.all.limit(20)
  end

  def show
  end
end
