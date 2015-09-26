namespace :check_point do
  desc "Try to finish check point. The task will schedule to perform itself"

  task try_to_finish: :environment do
    CheckPointWorker.perform_async
  end
end