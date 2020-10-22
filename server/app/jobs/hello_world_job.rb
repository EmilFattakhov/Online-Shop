class HelloWorldJob < ApplicationJob
  queue_as :default

  # To generate the migration for "delayed_job"'s queue, run:
  # rails g delayed_job:active_record

  # To generate a job file, run:
  # rails g job <job-name>

  # To start a worker to run jobs from your queue, run
  # in a seperate tab:
  # rails jobs:work

  def perform(*args)
    # Do something later
    puts "--------------------------------"
    puts "Running a Job . . . 🏃🏻‍♂️ 🏃🏻‍♀️"
    puts "--------------------------------"
  end
end
