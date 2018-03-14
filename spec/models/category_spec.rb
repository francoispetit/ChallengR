require 'rails_helper'

RSpec.describe Category, type: :model do
  before do
    @user = User.create(username:"testname", email:"test@email.com", password:"azerty")
    @chall = Challenge.new(goal:"hihi")
    @chall2 = Challenge.new(goal:"haha")
    @user.organized_challenges << @chall
    @user.organized_challenges << @chall2
    @chall.save
    @chall2.save
    @ca = Category.create
    @ca2 = Category.create
  end

  it "can have multiple challenges" do
    @ca.challenges << @chall
    @ca.challenges << @chall2
    expect(@ca.challenges).to eq([@chall, @chall2])
  end

  it "can be multiple on challenges" do
    @ca.challenges << @chall
    @ca2.challenges << @chall
    expect(@chall.categories).to eq([@ca, @ca2])
  end

end
