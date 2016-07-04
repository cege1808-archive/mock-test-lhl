require_relative 'spec_helper'

# Introduce the concept of a special weapon which is like a grenade but with a range of 1. However, in addition to being targetted at a specific robot, this one-time use weapon damages all robots surrounding the target. Its damage goes straight through shields (if you implemented shields) and directly reduces their health by 30 points.

describe "Special Weapon" do

  before :each do
    Robot.clear
    @robot = Robot.new
    @special = SpecialWeapon.new('special', 40, 50)
  end

  it "can attack the robot's health straight away" do
    # another_robot = Robot.new
    @special.hit(@robot)
    expect(@robot.health).to eq(50)
  end

  it "destroys all the enemies in the vicinity" do

    robot2 = Robot.new
    robot3 = Robot.new
    robot4 = Robot.new
    robot5 = Robot.new

    expect(@robot).to receive(:equipped_weapon).at_least(:once).and_return(@special) 
    expect(robot2).to receive(:position).at_least(:once).and_return([-1,0])
    expect(robot3).to receive(:position).at_least(:once).and_return([1,0])
    expect(robot4).to receive(:position).at_least(:once).and_return([0,1])
    expect(robot5).to receive(:position).at_least(:once).and_return([1,1])
    # binding.pry
    @robot.attack(robot2)

    expect(robot2.health).to eq(50)
    expect(robot3.health).to eq(50)
    expect(robot4.health).to eq(50)
    expect(robot5.health).to eq(100)
    expect(@equipped_weapon).to eq(nil)
  end

end
