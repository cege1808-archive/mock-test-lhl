class Grenade < Weapon

  GRENADE_WEIGHT = 40
  GRENADE_DAMAGE = 15
  GRENADE_RANGE = 2

  def initialize
    super("Grenade",GRENADE_WEIGHT ,GRENADE_DAMAGE)
    @range = GRENADE_RANGE
  end

end