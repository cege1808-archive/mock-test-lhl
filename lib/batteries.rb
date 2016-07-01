class Batteries < Item

  def initialize
    super("Batteries", 25)
  end

  def recharge(robot)
    robot.shield_points = 50
  end 

end
