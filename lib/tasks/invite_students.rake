
desc "Invite students that are near gandaria city by reading from a csv file"
task invite_students: :environment do
  log = ActiveSupport::Logger.new('log/invite_students.log')
  
  # Calling the class that process the input of a file, destination coordinates, tolerated distance, and options
  result = HangoutInvitation.new("students.csv", [-6.243376,106.784425], 14)
  result.print_sorted_result #print the result
end