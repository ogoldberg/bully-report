class SearchController < ApplicationController
  def index
    @schools = School.where('zip LIKE ? OR address ilike ? OR name ilike ? OR (lat ilike ? AND long ilike ?)', '%#{search}', '%#{search}', '%#{search}', '%#{search}', '%#{search}')  
  end
end
