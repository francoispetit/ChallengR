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

	User.create(username:"Albert", email:"albert@mail.com", password:"123456")
	User.create(username:"Bernard", email:"bernard@mail.com", password:"123456")
	User.create(username:"Caroline", email:"caroline@mail.com", password:"123456")
	User.create(username:"Danièle", email:"daniele@mail.com", password:"123456")

	Challenge.create(goal:"courir un marathon", image_url:"jogging800.jpg", deadline:"2018-04-01", organizer_id:1)
	Challenge.create(goal:"sauter comme un Yamakazi", image_url:"jump800.jpg", deadline:"2018-05-01", organizer_id:1)
	Challenge.create(goal:"danser les classiques", image_url:"dance800.jpg", deadline:"2018-06-01", organizer_id:1)
	Challenge.create(goal:"faire pousser des tomates", image_url:"tomatoe800.jpg", deadline:"2018-06-01",organizer_id:1)
	Challenge.create(goal:"monter sa startup", image_url:"startup800.jpg", deadline:"2018-06-01",organizer_id:1)
	Challenge.create(goal:"déguiser un crime", image_url:"crime800.jpg", deadline:"2018-06-01",organizer_id:1)


	Category.create(category_name:"sport")
	Category.create(category_name:"running")
	Category.create(category_name:"music")
	Category.create(category_name:"art")
	Category.create(category_name:"beginner")

	Challenge.first.categories << Category.find(1)
	Challenge.first.categories << Category.find(2)