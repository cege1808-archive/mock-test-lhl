require_relative 'spec_helper'

# The Robot class should keep track of all robots that are instantiated.

describe 'Robot' do 

  describe '#self.all' do
    before :each do
      @@all_robots = []
    end

    it "will list all the objects with class Robot" do

      robot1 = Robot.new
      robot2 = Robot.new
      robot3 = Robot.new

      expect(Robot.all).to eq([robot1, robot2, robot3])
    end

  end
  
end