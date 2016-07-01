require_relative 'spec_helper'

# The Robot class can be asked to return all robots in a given position (x,y). It should return an array of all the robots since multiple robots could potentially be at position 0,0 (for example)

describe "Robot" do 

    

  describe "#self.in_position" do
    before :each do
      @@all_robots = []
    end
    it "should return an array of all the position of robots" do
      robot1 = Robot.new
      robot2 = Robot.new
      robot3 = Robot.new
      expect(robot2).to receive(:position).and_return([1,0])

      expect(Robot.in_position(0,0)).to eq([robot1, robot3])  
    end
  end


end
