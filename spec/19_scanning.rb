require_relative 'spec_helper'

# A given robot should be able to scan its surroundings (tiles immediately next to its current @position) Note: You should leverage the class method implemented in #18


describe 'Robot' do
  describe '#scanning' do
    before :each do
      Robot.clear
    end

    it "should scan its surrounding tiles for other robots" do
      robot1 = Robot.new
      robot2 = Robot.new
      robot3 = Robot.new
      robot4 = Robot.new
      robot5 = Robot.new



      expect(robot2).to receive(:position).at_least(:once).and_return([-1,0])
      expect(robot3).to receive(:position).at_least(:once).and_return([1,0])
      expect(robot4).to receive(:position).at_least(:once).and_return([0,1])
      expect(robot5).to receive(:position).at_least(:once).and_return([1,1])

      # binding.pry

      expect(robot1.scanning).to eq([robot3,robot2,robot4])  
    end


  end
end