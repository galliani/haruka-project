require 'rails_helper'

RSpec.describe HangoutInvitation, :type => :model do
  
  before do
	  @destination_coord =  [-6.243376,106.784425]
	  @tolerated_gap = 14

  	@invitation = HangoutInvitation.new("students.csv", @destination_coord, @tolerated_gap)
  end

	subject { @invitation }

	it { should respond_to(:sorted_by_distance) }

	describe "result" do
		before { @result = @invitation.sorted_by_distance }

  	it "the first element is closer than the second" do
  	  expect(@result.first[:gap]).to be < @result.second[:gap]
  	end

  	it "the last element is no more than the tolerated_gap" do
  	  expect(@result.last[:gap]).to be <= @tolerated_gap
  	end
	end

end