class SpecialWeapon < Weapon

  def initialize(name, weight)
    super(name, weight, 30)
  end

  def hit(robot1)
      robot1.health -= 30
      surrounding_target = robot1.scan
      surrounding_target[:above].each do |robot|
        if !robot.nil?
          robot.health-=30
        end
      end
      surrounding_target[:below].each do |robot|
        if !robot.nil?
          robot.health-=30
        end
      end
      surrounding_target[:left].each do |robot|
        if !robot.nil?
          robot.health-=30
        end
      end
      surrounding_target[:right].each do |robot|
        if !robot.nil?
          robot.health-=30
        end
      end
  end
end
