require 'rails_helper'

RSpec.describe Challenge, type: :model do
  before do
    @chall = Challenge.new(goal:"YOLOOOOOO!!!")
    @user = User.create(username:"Alikae", email:"yo@lala.com", password:"azerty")
  end

  it "should save with valid data" do
    @chall.save
  end

  it "shouldn't save without goal" do
    !Challenge.create
  end

  it "can have organizer" do
  end

  it "can have attendees" do
  end

  it "can have subgoals" do
  end
end
