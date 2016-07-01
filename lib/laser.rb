class Laser < Weapon

LASER_WEIGHT = 125
LASER_DAMAGE = 25

  def initialize
    super("Laser", LASER_WEIGHT, LASER_DAMAGE)
  end

end