class TestJobEvery30Seconds < ActiveJob::Base
  def perform
    # put you scheduled code here
    puts "Hi, I'm a 30s crono job"
  end
end
