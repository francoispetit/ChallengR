object @user
attributes :username


child :attended_challenges do
  attributes :goal
  child do
    attributes :subgoal_string
  end
end

child :participations do
  attributes :user_id, :challenge_id, :stats
end
