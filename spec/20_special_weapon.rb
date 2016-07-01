require_relative 'spec_helper'

# Introduce the concept of a special weapon which is like a grenade but with a range of 1. However, in addition to being targetted at a specific robot, this one-time use weapon damages all robots surrounding the target. Its damage goes straight through shields (if you implemented shields) and directly reduces their health by 30 points.

describe "Special Weapon" do

  before :each do
    @robot = Robot.new
  end

  it "can attack the robot's health straight away" do
    # another_robot = Robot.new
    special = SpecialWeapon.new('special', 40, 50)
    special.hit(@robot)
    expect(@robot.health).to eq(50)
  end
end
