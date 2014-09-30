require 'factor-connector-api'
require 'rufus-scheduler'

Factor::Connector.service 'timer' do
  listener 'every' do
    start do |params|
      hours   = params['hours']
      minutes = params['minutes']
      seconds = params['seconds']
      times   = [hours, minutes, seconds]

      fail 'hours, minutes, or seconds, but only one can be used' if times.count { |t| !t.nil? } > 1
      fail 'hours, minutes, or seconds must be defined' if times.all? { |t| t.nil? }

      every = "#{minutes}m" if minutes
      every = "#{seconds}s" if seconds
      every = "#{hours}h"   if hours

      info "Starting timer every #{every}"

      @scheduler = Rufus::Scheduler.new
      begin
        @scheduler.every every do
          time = Time.now.to_s
          info "Trigger time at #{time}"
          start_workflow time_run: time
        end
      rescue
        fail "The time specified `#{every}` is invalid"
      end

    end
    stop do |_data|
      @scheduler.stop
    end
  end

  listener 'cron' do

    scheduler = Rufus::Scheduler.new

    start do |data|
      crontab = data['crontab']
      info "Starting timer using the crontab `#{crontab}`"

      fail 'No crontab specified' if !crontab || crontab.empty?

      begin
        scheduler.cron crontab do
          start_workflow time_run: Time.now.to_s
        end
      rescue => ex
        fail "The crontab entry `#{crontab}` was invalid.", exception: ex
      end

    end
    stop do |_data|
      scheduler.stop
    end
  end
end