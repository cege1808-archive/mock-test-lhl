class SpecialWeapon < Weapon

  def initialize(name, weight, damage)
    super(name, weight, damage)
  end

  def hit(enemy)
    enemy.wound_through_shield(damage)
  end

end
