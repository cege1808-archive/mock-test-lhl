require_relative 'spec_helper'

# Batteries are items that can be used by robot to recharge its shield. Implement Battery item that can be used to recharge the Robot’s shield. Batteries have a weight of 25.



describe Batteries do
  before :each do
    @batteries = Batteries.new
  end

  it "should be an item" do
    expect(@batteries).to be_an(Item)
  end

  it "has name 'Batteries'" do
    expect(@batteries.name).to eq("Batteries")
  end

  it "has 25 weight" do
    expect(@batteries.weight).to eq(25)
  end

  describe "#recharge" do
    before :each do
      @robot = Robot.new
      @batteries = Batteries.new
    end

    it "restores shield points" do
      @robot.wound(20)
      @batteries.recharge(@robot)
      expect(@robot.shield_points).to eq(50)
    end

  end
end

