# Creates a random number of reports for the given school
#
def create_reports_for_school(school)
  types = ["Physical", "Online/Cyber", "Verbal", "Emotional", "Other"]
  told  = ["Teacher", "Parent", "Friend", "Principle", "Nobody"]

  # Create a random number of reports for a school
  num = rand(0..25)
  i = 0
  while i <= num do
    report = Report.new
    report.school = school
    report.type_of_bullying = types.sample
    report.person_told = told.sample
    report.grade = rand(1..12).to_s
    report.save()
    i += 1
  end
end

# Load schools in batches of 1000 so we don't overload memory, otherwise we'd be
# loading 125K schools in memory whilst working on one at a time.
# Then, create data for each school

# 
## Uncomment this line to add records for all schools
#
# School.find_each(batch_size: 1000) { |school| create_reports_for_school(school) }

School.take(1000).each do |school| 
  create_reports_for_school(school)
end