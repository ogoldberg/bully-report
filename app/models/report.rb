class Report < ActiveRecord::Base
  belongs_to :school
  #attr_accessible :school_id, :type_of_bullying, :person_told, :happened_to
end
