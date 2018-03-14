require 'rails_helper'

RSpec.describe Subgoal, type: :model do
  before do
    @user = User.create(email:"yo@lala.com", password:"azerty", username:"itsme")
    @user.organized_challenges << @chall = Challenge.create(goal:"yolo")
    @sub = Subgoal.new(subgoal_string:"yololala", deadline:"10/11/2024", description:"hahaha", accomplished:false)
    @chall.subgoals << @sub
  end

  it "should save with valid data" do
    expect(@sub.save).to eq(true)
  end

  it "shouldn't save with invalid data" do
    expect(!Subgoal.new(subgoal_string:"", deadline:"10/11/2024").save).to eq(true)
    expect(!Subgoal.new(subgoal_string:"Yolo", deadline:"yolo!").save).to eq(true)
    @sub.challenge = nil
    expect(@sub.save).to be(false)
  end
end
