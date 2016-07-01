class BoxOfBolts < Item

REVIVAL_POINTS = 20

  def initialize
    super("Box of bolts", 25)
  end

  def feed(robot)
    robot.heal(REVIVAL_POINTS)
  end

end