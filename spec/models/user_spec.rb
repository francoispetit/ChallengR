require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = User.new(username:"testname", email:"test@email.com", password:"azerty")
  end

  it "should save with valid data" do
    expect(@user.save).to eq(true)
  end

  it "shouldn't save with invalid data" do
    expect(!User.new(username:"testname", email:"test@email.com", password:"az").save).to eq(true)
    expect(!User.new(username:"testname", email:"yolo@.com", password:"azerty").save).to eq(true)
    expect(!User.new(email:"test@mail.com", password:"azerty").save).to eq(true)
  end
end
