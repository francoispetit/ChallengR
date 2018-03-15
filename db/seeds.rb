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

	a=User.create(username:"Albert", email:"albert@mail.com", password:"123456")
        a.set_default_role(:admin)
        a.save
	User.create(username:"Bernard", email:"bernard@mail.com", password:"123456")
	User.create(username:"Caroline", email:"caroline@mail.com", password:"123456")
	User.create(username:"Danièle", email:"daniele@mail.com", password:"123456")
        a=User.create(username:"Vald", email:"v@l.d", password:"azerty")
        a.set_default_role(:vip)
        a.save

	Challenge.create(goal:"courir un marathon", image_url:"jogging800.jpg", deadline:"2018-04-01", organizer_id:User.find_by_username("Albert").id)
	Challenge.create(goal:"sauter comme un Yamakazi", image_url:"jump800.jpg", deadline:"2018-05-01", organizer_id:User.find_by_username("Albert").id)
	Challenge.create(goal:"danser les classiques", image_url:"dance800.jpg", deadline:"2018-06-01", organizer_id:User.find_by_username("Albert").id)
	Challenge.create(goal:"faire pousser des tomates", image_url:"tomatoe800.jpg", deadline:"2018-06-01", organizer_id:User.find_by_username("Albert").id)
	Challenge.create(goal:"monter sa startup", image_url:"startup800.jpg", deadline:"2018-06-01",organizer_id:User.find_by_username("Albert").id)
	Challenge.create(goal:"déguiser un crime", image_url:"crime800.jpg", deadline:"2018-06-01",organizer_id:User.find_by_username("Caroline").id)


	Challenge.find_by_goal("courir un marathon").subgoals << Subgoal.create(subgoal_string:"courir 10 km en moins d'1h", deadline:"2018-04-10", challenge_id:"1")
	Challenge.find_by_goal("courir un marathon").subgoals << Subgoal.create(subgoal_string:"courir 10 km en moins de 50mn", deadline:"2018-04-20", challenge_id:"1")
	Challenge.find_by_goal("courir un marathon").subgoals << Subgoal.create(subgoal_string:"courir 10 km en moins de 45 mn", deadline:"2018-04-30", challenge_id:"1")


	Category.create(category_name:"sport", id:1)
	Category.create(category_name:"running", id:2)
	Category.create(category_name:"music")
	Category.create(category_name:"art")
	Category.create(category_name:"beginner")

	Challenge.find_by_goal("courir un marathon").categories << [Category.find_by_category_name("sport"), Category.find_by_category_name("running")]
	Challenge.find_by_goal("courir un marathon").categories << [Category.find_by_category_name("sport"), Category.find_by_category_name("beginner")]

	User.find_by_username("Bernard").attended_challenges << Challenge.find_by_goal("courir un marathon")
	User.find_by_username("Caroline").attended_challenges << Challenge.find_by_goal("courir un marathon")
        a = User.find_by_username("Bernard").participations.find_by_challenge_id(Challenge.find_by_goal("courir un marathon").id)

	a.stats = {
            subgoal1:{done:true, date_accomplised:"2018-04-11"},
            subgoal2:{done:true, date_accomplised:"2018-04-20"},
            subgoal3:{done:true, date_accomplised:"2018-05-01"}
        }
        a.save
	a = User.find_by_username("Caroline").participations.find_by_challenge_id(Challenge.find_by_goal("courir un marathon").id) 
        a.stats = {
            subgoal1:{done:true, date_accomplised:"2018-04-10"}, 
	    subgoal2:{done:true, date_accomplised:"2018-04-22"},
	    subgoal3:{done:false}	
	}
        a.save




###Attention LA C'EST LA FIN!!!

Challenge.all.each do |c|
    a = Challenge.new(c.attributes.merge(id:nil, organizer_id:User.find_by_username("Vald").id, created_at:nil, updated_at:nil))
    c.subgoals.each do |s|
        b = Subgoal.new(s.attributes.merge(id:nil, challenge_id:nil, created_at:nil, updated_at:nil))
        a.subgoals << b
        b.save
    end
    c.categories.each do |ca|
        a.categories << ca
    end
    a.save
end
