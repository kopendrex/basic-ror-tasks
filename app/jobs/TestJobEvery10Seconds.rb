class TestJobEvery10Seconds < ActiveJob::Base
  def perform
    # put you scheduled code here
    puts "Hi, I'm a 10s crono job"
  end
end
