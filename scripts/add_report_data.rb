# Creates a random number of reports for the given school
# Uses "faker" gem to create data.
#
# @see https://github.com/stympy/faker
#
def create_reports_for_school(school)
  # Create a random number of reports for a school
  num = rand(0..25)
  i = 0
  while i <= num do
    report = Report.new()
  end

end

# Load schools in batches of 1000 so we don't overload memory, otherwise we'd be
# loading 125K schools in memory whilst working on one at a time.
# Then, create data for each school
schools.find_each(batch_size: 1000) { |school| create_reports_for_school(school) }
