RANDOM_100_CHARS = "SabrLizIIOM4LNqkoN2JtknHgAs1oZunS6guHn47UsfdUWb4viL1e6rVokZerBEVYawxVKd6acIDYwjPvS042ejbcmM9gDyT2A0I"
FactoryBot.define do
  factory :job_post, class: 'JobPost' do
    sequence(:title) { |n| Faker::Job.title + "#{n}" }
    # sequence is a method provided by factory-bot which keeps accepts a lambda injecting a variable n.
    # n is usually a number that factory-bot increments on every object it generates so we can use it to make sure all 
    # instances created are unique
    description { Faker::Job.field + "#{RANDOM_100_CHARS}" } 
    # All object created using Factories should be valid objects. In this case, 
    # we're adding 100 characters to the description of any job_post to make sure
    # it passes the description length validation
    location { Faker::Address.city }
    min_salary { rand(80_000..200_000)}
    max_salary { rand(200_000..400_000)}
    # The line below will create a user (using its
    #  factory) before creating a job post. Then, it will
    # associate that user to the job post. This is necessary
    # to pass the validation added by 'belongs_to' :user
    association(:user, factory: :user)
  end
end

# With this factory defined we can:
# FactoryBot.create(:job_post)