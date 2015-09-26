class CheckPointService
  attr_accessor :check_point

  def initialize(check_point)
    self.check_point = check_point
  end

  def finish!
    ActiveRecord::Base.transaction do
      check_point.finish!
      next_check_point.start! if next_check_point
    end
  end

  def try_to_finish
    finish! if next_check_point.should_have_started?
  end

  def next_check_point
    @next_check_point ||= check_point.mentee.check_points.unstarted.first
  end
end