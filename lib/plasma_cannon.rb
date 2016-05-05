class PlasmaCannon < Weapon

  attr_reader :range

  def initialize
    super("Plasma Cannon", 200, 55)
    @range = 1
  end

  def within_weapon_range?(vertical_distance, horizontal_distance)
    (vertical_distance <= range || horizontal_distance <= range)
  end
end
