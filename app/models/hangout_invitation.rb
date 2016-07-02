require 'geocoder'
require 'csv'

class HangoutInvitation
  def initialize(file, destination, within, options={})
  	@filename = File.join(Rails.root, file)
  	@destination = destination
  	@within = within
  	@header_bool = options[:header] || true
	@distance_unit = options[:unit] || :km
  	@total = 0
  	@matched_results = []
	  	
	puts "no problem with the setup, beginning to read the csv file...."
  end

  def csv_reading(file)
  	CSV.foreach(file, headers: @header_bool) do |row|
  	  row_hash = row.to_hash
	  
	  location = [ row_hash["latitude"],row_hash["longitude"] ]
	  gap = Geocoder::Calculations.distance_between(location, @destination, units: @distance_unit).round(2)

	  if gap <= @within #if the gap is less than or equal to the desired gap km
	  	hash = { id: row_hash["id"], name: row_hash["name"], gap: gap }
	  	@matched_results.push(hash)
	  	@total += 1
	  end
  	end
  	puts "There are matching #{@total} students"

  	return @matched_results
  end
  
  def sorted_by_distance
  	csv_reading(@filename).sort_by{ |hsh| hsh[:gap] }
  end

  def print_sorted_result
  	self.sorted_by_distance.each do |student|
  	  puts student.values.join(': ') + " km"
	end
  end

end