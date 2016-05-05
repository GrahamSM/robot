class Weapon < Item

attr_reader :damage, :weight

  def initialize(name, weight, damage)
    @name = name
    @weight = weight
    @damage = damage
  end

  def hit(robot)
    robot.wound(damage)
  end
end
