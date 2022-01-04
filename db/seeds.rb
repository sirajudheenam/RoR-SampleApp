class Seed
  attr_reader :seed
  def initialize
    @seed
  end


  def run
    generate_items
    generate_instruments
    generate_questions
  end

  def generate_items
    items = Item.create(
      [
        { name: "Vitamin C",
          description: "Citrus fruits, tomatoes and tomato juice, and potatoes. red and green peppers, kiwifruit, broccoli, strawberries, Brussels sprouts, and cantaloupe"
        },
        { name: "Vitamin D",
          description: "Its anti-inflammatory, antioxidant and neuroprotective properties support immune health, muscle function and brain cell activity. It can be found on fortified milk, fortified cereal, and fatty fish such as salmon, mackerel and sardines."
        },
        { name: "Vitamin E",
          description: "Vitamin E is a nutrient that's important to vision, reproduction, and the health of your blood, brain and skin.Foods rich in vitamin E include canola oil, olive oil, margarine, almonds and peanuts. You can also get vitamin E from meats, dairy, leafy greens and fortified cereals."
        },
        {
          name: "Painting Tips",
          description: "Scrap & Clean the wall before..."
        },
        {
          name: "Fish Curry Recipe",
          description: "It talks about Chettinadu Fish Curry recipe...."
        },
        {
          name: "Idly Recipe",
          description: "Delicious way to make Idly and Chutney"
        },
        {
          name: "COVID-19 Kolkata",
          description: "List of COVID-19 Vaccine Centers available in Kolkata"
        },
        {
          name: "Saving Tips",
          description: "How to save money electricity or anything you think precious..."
        },
        {
          name: "Mutton Curry Recipe",
          description: "It talks about Chettinadu Mutton Curry recipe...."
        },
        {
          name: "Dosa & Coconut Chutney Recipe",
          description: "Delicious way to make Dosa and Chutney"
        },
        {
          name: "COVID-19 Vaccine Centers in Berlin",
          description: "List of Vaccine Centers available in Berlin"
        }
      ]
    )
  end

  def generate_instruments
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
  end

  def generate_questions
    questions = Question.create([
      { email: 'samer@on-site.com', body: 'How is universe created ?'},
      { email: 'samer@on-site.com', body: 'How did the moon got formed ?'},
      {email: 'sirajudheenam@gmail.com', body: 'How old is the Milky Way?'},
      {email: 'samer.buna@gmail.com', body: 'How old is the universe?'}
      ])
  end
end

seed = Seed.new
seed.run

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

# # i=1
# # 20.times do
# #   Item.create({name: "Item-#{i}", description: "Item-#{i} - Desc"})
# #   i+=1
# # end
# # items = Item.create({name: 'yahoo', description: 'ancient search engine before google time'})

# i = 1
# 20.times do
#   item = Item.new
#   item.name = "Item-#{i}"
#   item.description = "Item-#{i} description."
#   item.save!
#   puts "Generated item  # #{item.id}"
# end
