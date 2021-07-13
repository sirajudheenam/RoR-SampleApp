# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# User.destroy_all
# Profile.destroy.all

# sam = User.create(name: 'Sam Miller', email: 'sam@example.org', login: 'sam', password: 'password')
# siraj = User.create(name: 'Sirajudheen', email: 'siraj@example.org', login: 'siraj', password: 'password')
# Profile.create( { :user_id => 1, :gender => "Male", :age => 38, :date_of_birth => "10/06/1981", :city => "Berlin", :country => "Germany", :subscribe => true })
# Profile.create( { :user_id => 2, :gender => "Female", :age => 38, :date_of_birth => "10/06/1981", :city => "Leicester", :country => "United Kingdom", :subscribe => true } )

# sam.avatar.attach(
# 	io: File.open('./public/avatars/man01.png'),
# 	filename: 'man01.png',
# 	content_type: 'application/png'
# 	)

instruments = [
    {"title":"Piano","token":"piano","count":13},
    {"title":"Bass Guitar","token":"bass","count":12},
    {"title":"Viola","token":"viola","count":12},
    {"title":"Synth","token":"synth","count":11},
    {"title":"Keyboard","token":"keyboard","count":9},
    {"title":"Saxophone","token":"saxophone","count":8},
    {"title":"Flute","token":"flute","count":8},
    {"title":"Drums","token":"drums","count":6},
    {"title":"Guitar","token":"guitar","count":5},
    {"title":"Violin","token":"violin","count":5},
    {"title":"Vocals","token":"vocals","count":4},
    {"title":"Cello","token":"cello","count":4}
  ]
Instrument.create(instruments)
