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

	User.create(username:"Albert", email:"albert@mail.com", password:"123456")
	User.create(username:"Bernard", email:"bernard@mail.com", password:"123456")
	User.create(username:"Caroline", email:"caroline@mail.com", password:"123456")
	User.create(username:"Danièle", email:"daniele@mail.com", password:"123456")


	Challenge.create(goal:"courir", duedate:"2018-04-01", organizer_id:1)
	Challenge.create(goal:"sauter", duedate:"2018-05-01", organizer_id:1)
	Challenge.create(goal:"danser", duedate:"2018-06-01", organizer_id:2)

	Challenge.find(1).subgoals.create(subgoal_string:"step1", description:"go", deadline:"2018-04-02", accomplished:true)
	Challenge.find(1).subgoals.create(subgoal_string:"step2", description:"go go", deadline:"2018-04-03", accomplished:false)
