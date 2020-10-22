# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# To run your seeds, do:
# rails db:seed
Like.delete_all 
Tagging.delete_all 
Tag.delete_all
Answer.delete_all
Question.delete_all
User.delete_all

NUM_QUESTIONS = 200
NUM_USERS = 10
NUM_TAGS = 10
PASSWORD = 'supersecret'

super_user = User.create(
    first_name: "Jon",
    last_name: "Snow",
    email: "js@winterfell.gov",
    address: Faker::Address.street_address, #👈🏻Step 8 : Updating seed file
    password: PASSWORD, 
    is_admin: true
)

NUM_TAGS.times do 
    Tag.create(
        name: Faker::Vehicle.make
    )
end

tags = Tag.all

NUM_USERS.times do 
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name

    User.create(
        first_name: first_name,
        last_name: last_name,
        email: "#{first_name.downcase}.#{last_name.downcase}@example.com",
        address: Faker::Address.street_address,#👈🏻Step 8 : Updating seed file
        password: PASSWORD
    )
end

users = User.all

NUM_QUESTIONS.times do 
    created_at = Faker::Date.backward(days: 365)
    q = Question.create(
        title: Faker::Hacker.say_something_smart,
        body: Faker::ChuckNorris.fact,
        created_at: created_at, 
        updated_at: created_at,
        view_count: Faker::Number.between(from: 1, to: 100),
        user: users.sample
    )

    if q.valid?
        q.answers = rand(0..15).times.map do 
            Answer.new(
                body: Faker::GreekPhilosophers.quote,
                user: users.sample
            )
        end
        q.likers = users.shuffle.slice(0, rand(users.count))
        q.tags = tags.shuffle.slice(0, rand(tags.count))
    end
end

question = Question.all
answer = Answer.all

puts Cowsay.say("Generated #{users.count} users", :stegosaurus)
puts Cowsay.say("Generated #{question.count} questions", :frogs)
puts Cowsay.say("Generated #{answer.count} answers for questions", :tux)
puts Cowsay.say("Generated #{Like.count} likes for questions", :bunny)
puts Cowsay.say("Generated #{tags.count} tags", :sheep)

puts "Login with #{super_user.email} and password: #{PASSWORD}"


