require 'rails_helper'

RSpec.describe Challenge, type: :model do
  before do
    @chall = Challenge.new(goal:"YOLOOOOOO!!!")
    @chall2= Challenge.new(goal:"heyhey")
    @user = User.create(username:"Alikae", email:"yo@lala.com", password:"azerty")
    @user.organized_challenges << @chall
    @user.organized_challenges << @chall2
    @sub = @chall2.subgoals.build(subgoal_string:"yoli", deadline:"11/10/2024", description:"yiha", accomplished:true)
    @chall2.save
  end

  it "should save with valid data" do
    expect(@chall.save).to eq(true)
  end

  it "shouldn't save without goal" do
    expect(Challenge.new.save).to eq(false)
  end

  it "shouldn't save without organizer" do
    @chall.organizer_id = nil
    expect(@chall.save).to eq(false)
  end

  it "has an organizer" do
    expect(@chall.organizer).to eq(@user)
  end

  it "can have attendees" do
    @chall.attendees << @user
    expect(@user.attended_challenges).to eq([@chall])
  end

  it "can have subgoals" do
    expect(Challenge.find(@sub.challenge_id)).to eq(@chall2)
  end
end
