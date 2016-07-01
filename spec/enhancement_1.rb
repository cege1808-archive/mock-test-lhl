require_relative 'spec_helper'


describe Robot do 
  before :each do 
    @robot = Robot.new
  end

  describe "#is_dead?" do
    it "returns true if robot's health is 0" do
      @robot.wound(@robot.health + 10)
      expect(@robot.is_dead?).to be true
    end

    it "returns false if robot's health > 0" do
      @robot.wound(@robot.health - 10)
      expect(@robot.is_dead?).to be false
    end

  end 

  describe "#heal!" do 
    it "should raise an exception if robot is dead" do
      @robot.wound(@robot.health + 10)
      expect { @robot.heal!(20) }.to raise_error(Robot::RobotAlreadyDeadError)
    end

    it "should not raise an exception if robot is still alive" do
      @robot.wound(@robot.health - 10)
      @robot.heal!(20)
      expect(@robot.health).to eq(30)
    end
  end

  describe "#attack" do
    it "should raise an exception if enemy is an item" do
      random_item = Item.new("random", 40)
      expect { @robot.attack(random_item) }.to raise_error(Robot::UnattackableEnemy)
    end

    it "should not raise an exception only if enemy is a Robot" do
      another_robot = Robot.new
      @robot.attack(another_robot)
      expect(another_robot.health).to eq(95)
    end

  end

end


