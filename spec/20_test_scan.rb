require_relative 'spec_helper'
require 'pp'

describe Robot do

  describe "#scan" do
    before :each do
      @robot1 = Robot.new
      @robot2 = Robot.new
      @robot3 = Robot.new
      @robot4 = Robot.new
      @robot5 = Robot.new
    end

    it "should work.." do
      @robot1.move_left
      @robot2.move_up
      @robot3.move_right
      @robot4.move_down
      hash = @robot5.scan
      pp hash
    end
  end
end
