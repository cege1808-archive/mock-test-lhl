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
  INITIAL_SHIELD = 50
  @@all_robots = []

  attr_reader :items, :xpos, :ypos
  attr_accessor :equipped_weapon, :health, :shield_points

  def initialize 
    @xpos = INITIAL_ON_X_AXIS
    @ypos = INITIAL_ON_Y_AXIS
    @items = []
    @health = INITIAL_HEALTH
    @equipped_weapon = INITIAL_WEAPON
    @shield_points = INITIAL_SHIELD
    @@all_robots << self
  end

  def position
    [@xpos, @ypos]
  end

  def scanning
    # neighbor = []
    # other_robot = Robot.all_position
    # other_robot.delete(self.position)
    # other_robot.select do |robot_position|
    #   dx = (robot_position[0] - xpos)
    #   dy = (robot_position[1] - ypos)
    #   if dx.abs <= 1 && dy.abs <= 1
    #     neighbor << [dx,dy] 
    #   end
    # end
    # neighbor
    
  end

  #Class Method
  def self.all
    @@all_robots
    # ObjectSpace.each_object(self).to_a
  end

  # def self.all_position
  #   self.all.map { |robot| robot.position }
  # end

  def self.in_position(x,y)
    robots_in_position = []
    self.all.each do |robot| 
      if robot.position ==  [x,y]
        robots_in_position << robot
      end
    end
    robots_in_position
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
    shield_points_left = @shield_points - damage_taken

    if shield_points_left > 0
      @shield_points = [0, (@shield_points - damage_taken)].max
    elsif shield_points_left < 0 
      @health = [MINIMUM_HEALTH, (@health + shield_points_left)].max
      @shield_points = 0
    elsif shield_points == 0
      @health = [MINIMUM_HEALTH, (@health - damage_taken)].max
    end
  end

  def wound_through_shield(damage_taken)
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
