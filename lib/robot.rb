require_relative 'item'
class Robot

  attr_accessor :position, :items, :health, :equipped_weapon
  MAX_WEIGHT = 250

  def initialize
    @position = [0,0]
    @items = []
    @health = 100
    @equipped_weapon = nil
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
    if item.is_a?(Weapon)
      @equipped_weapon = item
    else
      can_pick_up?(item) ? @items << item : false
    end
  end

  def can_pick_up?(item)
    (item.weight + items_weight) <= 250
  end

  def items_weight
    weight = 0
    if items.size == 0
      weight
    else
      @items.each do |item|
        weight += item.weight
      end
    end
    weight
  end


  def wound(damage)
    if damage > @health
      @health = 0
    else
      @health -= damage
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

  def attack(robot2)
    @equipped_weapon ? @equipped_weapon.hit(robot2) : robot2.wound(5)
  end

  def attack!(robot2)
    if !(robot2.is_a?(Robot))
        raise Exception.new("The target is not a robot!")
    else
      attack(robot2)
    end
  end

end
