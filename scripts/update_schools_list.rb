require "net/http"
require "open-uri"
require "nokogiri"

state_abbrs = ["AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL", "GA", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY"]
school_ids = School.pluck("external_id")

def save_schools_in_state(state_abbr, school_ids)
  target_url = "http://www.fizber.com/xml_data/xml_school_data.xml?state=#{state_abbr}"
  doc = Nokogiri::XML(open(target_url))
  doc.xpath("//school").each do |school_xml|
    school = School.parse_xml(school_xml)
    school.save unless school_ids.include?(school.external_id)
  end
end

state_abbrs.each { |state_abbr| save_schools_in_state(state_abbr, school_ids) }

