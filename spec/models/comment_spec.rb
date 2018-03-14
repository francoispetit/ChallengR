require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @user = User.create(username:"testname", email:"test@email.com", password:"azerty")
    @chall = Challenge.new(goal:"yeah")
    @user.organized_challenges << @chall
    @comm = Comment.new(body: "MyFirstComment")
    @user.comments << @comm
    @chall.comments << @comm
    @comm2 = Comment.new(body:"really?")
    @user.comments << @comm2
    @comm.comments << @comm2
  end

  it "save on challenge" do
    expect(@comm.save).to be(true)
  end

  it "save on comment" do
    @comm.save
    expect(@comm2.save).to be(true)
  end

  it "don't save with invalid data" do
    @comm.body = ""
    expect(@comm.save).to be(false)
    @comm.body = "yo"
    @comm.commentable = nil
    expect(@comm.save).to be(false)
    @comm2.user = nil
    expect(@comm2.save).to be(false)
  end
end
