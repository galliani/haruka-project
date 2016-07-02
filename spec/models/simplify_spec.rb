require 'rails_helper'

RSpec.describe Simplify, :type => :model do
  	
  before { @setup = Simplify.new }
	subject { @setup }

	it { should respond_to(:begin_flatten) }
  it { should respond_to(:array_flattening) }

  context "when the input is an array" do
    before do 
      @test_array =  [1, [2,3], [4, [5], [[6], [7]], [[[8]]] ] ] 
      @result = @setup.begin_flatten(@test_array)
    end

    it "successfully integrate all elements into a single array" do
      expect(@result).to eq [1, 2, 3, 4, 5, 6, 7, 8]
    end
  end

  context "when the input is not an array" do
    before do 
      @test_array =  "1, 2, 3"
      @result = @setup.begin_flatten(@test_array)
    end

    it "successfully integrate all elements into a single array" do
      expect(@result).to eq nil
    end
  end


end