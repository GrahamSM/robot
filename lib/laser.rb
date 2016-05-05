class Laser < Weapon
  attr_reader :range
  def initialize
    super("Laser", 125, 25)
    @range = 1
  end

  def within_weapon_range?(vertical_distance, horizontal_distance)
    (vertical_distance <= range || horizontal_distance <= range)
  end

end
