# This worker will specialize itself like a cron jobs
# The reason is that we can't run cron job in Heroku, the Heroku Scheduler cost money
# So ...
require 'sidekiq'

class CheckPointWorker
  include Sidekiq::Worker

  def perform
    CheckPoint.started.find_each do |check_point|
      CheckPointService.new(check_point).try_to_finish
    end

    # Schedule itself to perform again
    # Beware of duplication task, will need to clean up task some how, so that only one task we be scheduled at a time
    CheckPointWorker.perform_in(30.minutes)
  end
end