require_relative 'spec_helper'

describe Shield do
  before :each do
    @shield = Shield.new(50)
  end

  describe ".new " do
    it "should have 50 points" do
      expect(@shield.points).to equal(50)
    end
  end
end

describe Robot do
  before :each do
    @robot = Robot.new
  end
  describe ".new" do
    it "should have a shield with 50 points" do
      expect(@robot.shield.points).to equal(50)
    end
  end

  describe "#wound" do
    it "should take 50 points from the shield and 10 points from the robot" do
      @robot.wound(60)
      expect(@robot.health).to equal(90)
      expect(@robot.shield.points).to equal(0)
    end

    it "should deplete the shield and kill the robot" do
      @robot.wound(160)
      expect(@robot.health).to equal(0)
      expect(@robot.shield.points).to equal(0)
      begin
        expect(@robot.heal!(50)).to raise_error
      rescue Exception => e
      end
    end

  end
end
