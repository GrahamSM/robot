require_relative 'spec_helper'

describe Robot do


  describe "#in_position" do
    before :each do
      @robot = Robot.new
      @robot1 = Robot.new
      @robot2 = Robot.new
    end
    it "should return an array of size two when one of three robots moves from [0,0]" do
      @robot.move_left
      expect((Robot.in_position(0,0)).size).to eq(2)
    end
  end
end
