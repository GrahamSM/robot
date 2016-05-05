class Battery < Item

  def initialize
    super("Battery", 25)
  end

  def recharge(robot)
    robot.shield.points = 50
  end

end
