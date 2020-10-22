require 'rails_helper'
require 'byebug'

RSpec.describe JobPost, type: :model do
  def current_user 
    @current_user ||= FactoryBot.create(:user)
  end
  describe "validation" do 
    describe "title" do 
      it "requires a title" do 
        # Given 
        job_post = FactoryBot.build(:job_post, title: nil) 

        # when 
        job_post.valid?

        # then
        # expect is passed a value we're asserting 
        # we can chain .to()
        # .to() accepts an assertion/expectation clause

        expect(job_post.errors.messages).to(have_key(:title))
      end

      it "is unique" do 
        persisted_job_post = FactoryBot.create(:job_post)
        job_post = FactoryBot.build(:job_post, title: persisted_job_post.title)

        job_post.valid?

      
        expect(job_post.errors.messages).to(have_key(:title))
      end 
    end

    describe "description" do 
      it "requires a description" do 
        job_post = FactoryBot.build(:job_post, description: nil)

        job_post.valid? 

        expect(job_post.errors.messages).to(have_key(:description))
      end

      it "must be longer than  100 characters" do 
        # Given 
        job_post = FactoryBot.build(:job_post, description: 'hello')

        # When 
        job_post.valid?

        # then 
        expect(job_post.errors.messages).to(have_key(:description))
      end
    end

    describe "salary_min" do 
      it "must be a number and greater than 30_000" do 
        job_post = FactoryBot.build(:job_post, min_salary: 20_000)

        job_post.valid? 

        expect(job_post.errors.details[:min_salary][0][:error]).to(be(:greater_than_or_equal_to))
      end
    end

    describe "location" do 
      it "is required" do 
        job_post = FactoryBot.build(:job_post, location: nil)

        job_post.valid? 

        expect(job_post.errors.messages).to(have_key(:location))
      end 
    end

  end

  # As per Ruby docs, methods that are described with a '.' in front 
  # are class methods, while those described with a '#' in front are 
  # instance methods 
  describe ".search" do 
    it "should find the JobPosts that has the search term" do
      # GIVEN 
      # 3 job posts in the db
      job_post_1 = JobPost.create(
        title: "Software Engineer",
        description: "Best job ever, we use React, Rails, Best job ever, we use React, Rails,Best job ever, we use React, Rails,Best job ever, we use React, Rails,Best job ever, we use React, Rails,Best job ever, we use React, Rails,Best job ever, we use React, Rails,Best job ever, we use React, Rails,Best job ever, we use React, Rails,",
        min_salary: 50_000,
        location: 'Vancouver BC',
        user: current_user
      )

      job_post_2 = JobPost.create(
        title: "Web Programmer",
        description: "software Developing games using C++, C, HTML, CSS and JavaScript Developing games using C++, C, HTML, CSS and JavaScript Developing games using C++, C, HTML, CSS and JavaScript Developing games using C++, C, HTML, CSS and JavaScript Developing games using C++, C, HTML, CSS and JavaScript Developing games using C++, C, HTML, CSS and JavaScript",
        min_salary: 50_000,
        location: 'Burnaby BC',
        user: current_user
      )

      job_post_3 = JobPost.create(
        title: "Mobile Developer",
        description: "Building web, mobile and progressive apps using language, frameworks, libraries and technologies including but not limitted to JavaScript, HTML5, CSS3, Rails, Node.js, express.js, React.js, Redux for state management. Join us!",
        min_salary: 80_000,
        location: 'Vancouver BC',
        user: current_user
      )

      # WHEN 
      # searching for 'software'
      results = JobPost.search('software')
      # THEN
      # job_post_1 & job_post_2 are returned
      expect(results).to eq([job_post_1, job_post_2])
    end
  end
end
