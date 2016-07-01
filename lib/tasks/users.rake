require 'geocoder'
require 'csv'

# namespace :users do
  desc "Invite students that are near gandaria city"
  task :invite_students do
  	log = ActiveSupport::Logger.new('log/invite_students.log')
  	filename = File.join Rails.root, "students.csv"
	destination = [-6.243376,106.784425] #"6.243376, 106.784425"
 	total = 0
 	matched_students = []

	puts "no problem with the setup, beginning to read the csv file...."

  	CSV.foreach(filename, headers: true) do |row|
  	  student_hash = row.to_hash
	  
	  location = [ student_hash["latitude"],student_hash["longitude"] ]
	  gap = Geocoder::Calculations.distance_between(location, destination, units: :km).round(2)

	  if gap <= 14 #if the gap is within 14 km
	  	hash = { id: student_hash["id"], name: student_hash["name"], gap: gap }
	  	matched_students.push(hash)
	  	total += 1
	  end
  	end

  	puts "end of csv file reading"

  	sorted_match = matched_students.sort_by{ |hsh| hsh[:gap] }
  	sorted_match.each do |student|
  	  puts student.values.join(': ') + " km"
	end
	
  	puts "There are matching #{total} students"
  end

# end
