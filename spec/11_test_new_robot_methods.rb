require_relative 'spec_helper'

describe Robot do
  before :each do
    @robot1 = Robot.new
    @robot2 = Robot.new
    @cannon = PlasmaCannon.new
    @item = Item.new("Not a robot", 25)
  end

  describe '#heal!' do
    it "should throw an exception if robot is dead" do
      @robot1.health = 0
      begin
        expect(@robot1.heal!(50)).to raise_exception(RobotAlreadyDeadError)
      rescue Exception => e
      end
    end
  end

  describe '#attack!' do
    it "should throw an exception if target is not a robot" do
      begin
        expect(@robot1.attack!(@item)).to raise_exception(NotARobotError)
      rescue Exception => e
      end
    end
  end
end
