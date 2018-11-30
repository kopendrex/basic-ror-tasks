class DummyController < ApplicationController

  def index
    # this will be rendered by app/views/sales/index.html.erb View
  end

  def report
    ## this would be triggered in sync mode
    # generate_report()

    ## this (app/workers/report_worker.rb) will be queued in redis and processed by sidekiq thread
    # Hint: you need to run it first ($ sidekiq -c 1)
    ReportWorker.perform_async("11-29-2018", "11-30-2018")
    render plain: "REQUEST TO GENERATE A REPORT ADDED TO THE QUEUE"
  end

  private
  def generate_report
    sleep 30
  end
end
