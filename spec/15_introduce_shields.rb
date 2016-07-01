require_relative 'spec_helper'
# Robots can start with 50 shield points. When the robot is damaged it first drains the shield and then starts affecting actual health.


describe Robot do 
  before :each do
    @robot = Robot.new
  end

  it "should have an initial of 50 shield points" do
    expect(@robot.shield_points).to eq(50)
  end

  it "should decrease shield points before health" do
    @robot.wound(40)
    expect(@robot.shield_points).to eq(10)
    expect(@robot.health).to eq(100)
  end

  it "should decrease health if shield points run out" do
    @robot.wound(55)
    expect(@robot.shield_points).to eq(0)
    expect(@robot.health).to eq(95)
  end


end
