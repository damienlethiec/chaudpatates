# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Location.destroy_all
City.destroy_all
User.destroy_all

usain = User.create!(
  email: "usain@mail.com",
  password: "usainbolt",
  first_name: "Usain",
  last_name: "Bolt",
  photo: Cloudinary::Uploader.upload("http://www.buzzdefou.com/wp-content/uploads/2016/08/usain_bolt-1250x750.jpg")
  )

kenenisa = User.create!(
  email: "kenenisa@mail.com",
  password: "kenenisa",
  first_name: "Kenenisa",
  last_name: "Bekele",
  is_coach: true,
  photo: Cloudinary::Uploader.upload("https://upload.wikimedia.org/wikipedia/commons/4/4a/Kenenisa_Bekele_Berlin_2009.jpg")
  )

paris = City.create!(
	name: "Paris",
	user_id: kenenisa.id,
	photo: Cloudinary::Uploader.upload("https://a4.odistatic.net/images/landingpages/vacation/640x480/paris_640x480.jpg")
	)

tuesday_session = Session.create!(
	day: 1,
	time_of_day: Time.new(2016, 10, 31, 19, 0, 0, "+02:00").strftime("%H:%M:%S"),
	city_id: paris.id
	)

friday_session = Session.create!(
	day: 4,
	time_of_day: Time.new(2016, 10, 31, 19, 0, 0, "+02:00").strftime("%H:%M:%S"),
	city_id: paris.id
	)

le_wagon = Location.create!(
	name: "Le Wagon",
	address: "16 Villa Gaudelet, 75011 Paris",
	photo: Cloudinary::Uploader.upload("http://lewagon.github.io/ui-components/images/lewagon.png")
	)
