class Robot

  #Errors
  class RobotAlreadyDeadError < StandardError
  end

  class UnattackableEnemy < StandardError
  end

  #Constants
  INITIAL_ON_X_AXIS = 0
  INITIAL_ON_Y_AXIS = 0
  INITIAL_HEALTH = 100
  CAPACITY = 250
  DEFAULT_ATTACK_POWER = 5
  INITIAL_WEAPON = nil
  MINIMUM_HEALTH = 0
  MAXIMUM_HEALTH = 100

  attr_reader :items, :xpos, :ypos
  attr_accessor :equipped_weapon, :health

  def initialize 
    @xpos = INITIAL_ON_X_AXIS
    @ypos = INITIAL_ON_Y_AXIS
    @items = []
    @health = INITIAL_HEALTH
    @equipped_weapon = INITIAL_WEAPON
  end

  def position
    [@xpos, @ypos]
  end

  #Movements
  def move_left
    @xpos -= 1
  end

  def move_right
    @xpos += 1
  end

  def move_up
    @ypos += 1
  end

  def move_down
    @ypos -= 1
  end

  #Item Interaction
  def pick_up(item)
    if (items_weight + item.weight <= CAPACITY)
      items << item
      if item.is_a? Weapon
        return @equipped_weapon = item
      elsif (item.is_a? BoxOfBolts) && (health <= 80)
        return item.feed(self)
      end
      true
    else
      false
    end
  end

  def items_weight
    items.inject(0) { |acc, item| acc + item.weight }
    # items.map { |item| item.weight }.inject(0) {|total, weight| total + weight}
  end

  #Actions
  def wound(damage_taken) 
    # @health -= damage_taken
    # @health = 0 if @health < 0
    @health = [MINIMUM_HEALTH, (@health - damage_taken)].max
  end

  def heal(revival_points)
    # @health += revival_points
    # @health = 100 if health > 100
    @health = [MAXIMUM_HEALTH, (@health + revival_points)].min
  end

  def is_dead?
    @health == MINIMUM_HEALTH
  end

  def heal!(revival_points)
    if is_dead?
      raise Robot::RobotAlreadyDeadError
    else
      heal(revival_points)
    end
  end

  def distance_from_enemy(enemy)
    distance = (self.xpos - enemy.xpos).abs + (self.ypos - enemy.ypos).abs 
  end

  def attack(enemy)
    if enemy.is_a? Robot
      if distance_from_enemy(enemy) <= 2 && (@equipped_weapon.is_a? Grenade)
          @equipped_weapon.hit(enemy)
          @equipped_weapon = nil

      elsif distance_from_enemy(enemy) <= 1
        if @equipped_weapon.is_a? Weapon
          @equipped_weapon.hit(enemy)
        else
          enemy.wound(DEFAULT_ATTACK_POWER)
        end
      end

    else
      raise Robot::UnattackableEnemy
    end

  end

end
