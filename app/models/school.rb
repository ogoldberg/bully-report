# == Schema Information
#
# Table name: schools
#
#  id          :integer          not null, primary key
#  external_id :integer
#  name        :string(255)
#  grades      :string(255)
#  address     :string(255)
#  phone       :string(255)
#  zip         :integer
#  lat         :float
#  lng         :float
#  created_at  :datetime
#  updated_at  :datetime
#

class School < ActiveRecord::Base
   acts_as_mappable :default_units => :miles,
                    :default_formula => :sphere,
                    :distance_field_name => :distance,
                    :lat_column_name => :lat,
                    :lng_column_name => :lng

  has_many :reports
  def self.parse_xml(school_xml)
    School.new({
      external_id: school_xml.xpath("id").text,
      name: school_xml.xpath("school_name").text,
      grades: school_xml.xpath("grades").text,
      address: school_xml.xpath("address").text,
      phone: school_xml.xpath("phone").text,
      zip: school_xml.xpath("zip").text,
      lat: school_xml.xpath("lat").text,
      lng: school_xml.xpath("lng").text
    })
  end

end
