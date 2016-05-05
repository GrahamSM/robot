class Robot

  attr_accessor :position, :items, :health, :equipped_weapon, :shield
  MAX_WEIGHT = 250
  @@robots = []

  def initialize
    @position = [0,0]
    @items = []
    @health = 100
    @equipped_weapon = nil
    @shield = Shield.new(50)
    @@robots << self
  end

  def move_left
    @position[0] -= 1
  end

  def move_right
    @position[0] += 1
  end

  def move_up
    @position[1] += 1
  end

  def move_down
    @position[1] -= 1
  end

  def pick_up(item)
    if item.is_a?(Weapon) && can_pick_up?(item)
      @equipped_weapon = item
    elsif item.is_a?(BoxOfBolts) && can_pick_up?(item)
        @items << item
        if health <= 80
          item.feed(self)
        end
    elsif can_pick_up?(item)
      @items << item
    else
      puts "Too heavy!"
    end
  end

  def can_pick_up?(item)
    (item.weight + items_weight) <= 250 && item.is_a?(Item)
  end

  def items_weight
    items.inject(0){|sum,x| sum + x }
  end

  def get_shield_damage(damage)
    if @shield.nil?
      shield_damage = 0
    elsif damage>@shield.points
      shield_damage = @shield.points
    else
      shield_damage = damage
    end
  end

  def get_robot_damage(damage, shield_damage)
    robot_damage = damage - shield_damage
  end

  def wound(damage)
    shield_damage = get_shield_damage(damage)
    robot_damage = get_robot_damage(damage, shield_damage)
    if !(@shield.nil?)
      @shield.points -= shield_damage
    end
    @health -= robot_damage
    if shield_damage + robot_damage > @health
      @health = 0
    end
  end

  def heal(amount)
    if amount + @health > 100
      @health = 100
    else
      @health += amount
    end
  end

  def heal!(amount)
    if @health <= 0
      raise RobotAlreadyDeadError.new("This robot is already dead!")
    else
      heal(amount)
    end
  end

  def get_vertical_distance(robot2)
    vertical_distance = (robot2.position[1]-self.position[1]).abs
  end

  def get_lateral_distance(robot2)
    lateral_distance = (robot2.position[0]-self.position[0]).abs
  end

  def attack(robot2)
    vertical_distance = get_vertical_distance(robot2)
    lateral_distance = get_lateral_distance(robot2)
    #binding.pry
    if !(@equipped_weapon) && vertical_distance <= 1 && lateral_distance <= 1
      robot2.wound(5)
    elsif @equipped_weapon && (vertical_distance <= @equipped_weapon.range) && (lateral_distance <= @equipped_weapon.range)
      @equipped_weapon.hit(robot2)
      if @equipped_weapon.name == "Grenade"
        @equipped_weapon = nil
      end
    else
      puts "Unable to attack!"
    end
  end

  def attack!(robot2)
    if !(robot2.is_a?(Robot))
        raise Exception.new("The target is not a robot!")
    else
      attack(robot2)
    end
  end

  def scan
    surroundings = {}
    up = Robot.in_position(@position[0], @position[1]+1)
    if up
      surroundings[:above] = up
    end
    down = Robot.in_position(@position[0], @position[1]-1)
    if down
      surroundings[:below] = down
    end
    right = Robot.in_position(@position[0]+1, @position[0])
    if right
      surroundings[:right] = right
    end
    left = Robot.in_position(@position[0]-1, @position[0])
    if left
      surroundings[:left] = left
    end
    if surroundings
      puts "You have #{surroundings[:above].size} enemies above you."
      puts "#{surroundings[:below].size} enemies below you"
      puts "#{surroundings[:left].size} enemies to the left of you, and"
      puts "#{surroundings[:right].size} enemies to the right of you."
    end
    return surroundings
  end

  class << self
    def in_position(x,y)
      position = []
      position[0] = x
      position[1] = y
      robots_in_position = []
      @@robots.each do |robot|
        if robot.position == position
          robots_in_position << robot
        end
      end
      return robots_in_position
    end
  end

end
