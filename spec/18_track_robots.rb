require_relative 'spec_helper'

describe Robot do
  before :each do
    @robot = Robot.new
  end

  describe ".new" do
    it "should add self to @@robots" do
      expect(Robot.class_variable_get(:@@robots).size).to eq(1)
    end
  end
end
