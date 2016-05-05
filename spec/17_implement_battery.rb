require_relative 'spec_helper'

describe Battery do

  before :each do
    @battery = Battery.new
  end
  describe ".new" do
    it "should have weight 25 and name Battery" do
      expect(@battery.weight).to equal(25)
      expect(@battery.name).to eq("Battery")
    end
  end
end

describe Robot do
  before :each do
    @robot = Robot.new
    @battery = Battery.new
  end

  describe "#pick_up" do
    it "should be able to pick up a battery" do
      @robot.pick_up(@battery)
      expect(@robot.items[0].class).to equal(Battery)
    end
  end

  describe "#recharge" do
    it "should set shield points back to 50" do
      @robot.pick_up(@battery)
      @robot.wound(40)
      binding.pry
      @robot.items[0].recharge(@robot)
      expect(@robot.shield.points).to eq(50)
    end
  end
end
