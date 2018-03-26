# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


	User.delete_all
	Challenge.delete_all
	Subgoal.delete_all
	Category.delete_all
	Participation.delete_all
	Target.delete_all

	a=User.create(username:"Albert", email:"albert@mail.com", password:"123456")
  a.set_default_role(:admin)
  a.save

  a=User.create(username:"The Red User", email:"v@l.d", password:"azerty")
  a.set_default_role(:vip)
  a.save

	Challenge.create(goal:"courir un marathon", deadline:"2018-04-01", organizer_id:User.find_by_username("Albert").id)

	Unit.create(unit_name:"kilometres", challenge_id:Challenge.find_by_goal("courir un marathon").id)
	Unit.create(unit_name:"minutes", challenge_id:Challenge.find_by_goal("courir un marathon").id)
	Unit.create(unit_name:"pompes", challenge_id:Challenge.find_by_goal("courir un marathon").id)

	Challenge.find_by_goal("courir un marathon").subgoals << Subgoal.create(subgoal_string:"courir 10 km en moins d'1h", deadline:"2018-04-10", challenge_id:"1")
	Challenge.find_by_goal("courir un marathon").subgoals << Subgoal.create(subgoal_string:"courir 10 km en moins de 50mn", deadline:"2018-04-20", challenge_id:"1")
	Challenge.find_by_goal("courir un marathon").subgoals << Subgoal.create(subgoal_string:"courir 10 km en moins de 45 mn", deadline:"2018-04-30", challenge_id:"1")
	Subgoal.find_by_subgoal_string("courir 10 km en moins d'1h").targets << Target.create(value:"10", unit_id:Unit.find_by_unit_name("kilometres").id)
	Subgoal.find_by_subgoal_string("courir 10 km en moins d'1h").targets << Target.create(value:"60", unit_id:Unit.find_by_unit_name("minutes").id)
	Subgoal.find_by_subgoal_string("courir 10 km en moins de 50mn").targets << Target.create(value:"10", unit_id:Unit.find_by_unit_name("kilometres").id)
	Subgoal.find_by_subgoal_string("courir 10 km en moins de 50mn").targets << Target.create(value:"50", unit_id:Unit.find_by_unit_name("minutes").id)

	Category.create(category_name:"sport")
	Category.create(category_name:"running")
	Category.create(category_name:"music")
	Category.create(category_name:"art")
	Category.create(category_name:"beginner")

	Challenge.all.each do |c|
    a = Challenge.new(c.attributes.merge(id:nil, organizer_id:User.find_by_username("The Red User").id, created_at:nil, updated_at:nil))
    c.subgoals.each do |s|
        b = Subgoal.new(s.attributes.merge(id:nil, challenge_id:nil, created_at:nil, updated_at:nil))
        a.subgoals << b
        b.save
    end
    c.categories.each do |ca|
        a.categories << ca
    end
    a.save
    c.attendees << c.organizer
    c.save
end
