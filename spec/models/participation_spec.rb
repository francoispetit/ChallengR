require 'rails_helper'

RSpec.describe Participation, type: :model do
  before do
    @user = User.create(username:"testname", email:"test@email.com", password:"azerty")
    @challenge = Challenge.new(goal:"yala")
    @user.organized_challenges << @challenge
    @challenge.save
  end
  it "is create" do
    expect(@user.participations.find_by_challenge_id(@challenge.id)).to eq(@challenge.participations.find_by_user_id(@user.id))
  end
end
