require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = User.new(username:"testname", email:"test@email.com", password:"azerty")
  end

  it "should save with valid data" do
    @user.save
  end

  it "shouldn't save with invalid data" do
    !User.new(username:"testname", email:"test@email.com", password:"az").save && !User.new(username:"testname", email:"yolo@.com", password:"azerty").save && !User.new(email:"test@mail.com", password:"azerty").save
  end
end
