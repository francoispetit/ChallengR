require 'rails_helper'

RSpec.describe Subgoal, type: :model do
  before do
    @sub = Subgoal.new(subgoal_string:"yololala", duedate:"10/11/2024", description:"hahaha")
  end

  it "should save with valid data" do
    @sub.save
  end

  it "shouldn't save with invalid data" do
    !Subgoal.new(subgoal_string:"", duedate:"10/11/2024").save && !Subgoal.new(subgoal_string:"Yolo", duedate:"yolo!").save
  end
end
