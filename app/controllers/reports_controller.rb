class ReportsController < ApplicationController

  def index
    @index = Report.all.limit(20)
  end

  def show
  end
end
