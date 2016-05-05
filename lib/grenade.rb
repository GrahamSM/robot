class Grenade < Weapon

  attr_reader :range

  def initialize
    super("Grenade", 40, 15)
    @range = 2
  end

  def within_weapon_range?(vertical_distance, horizontal_distance)
    binding.pry
    (vertical_distance <= range && horizontal_distance <= range)
  end

end
