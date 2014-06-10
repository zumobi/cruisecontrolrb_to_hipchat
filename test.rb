require 'rufus-scheduler'

Process.daemon

scheduler = Rufus::Scheduler.new

scheduler.every '3s' do
  puts 'Hello... Rufus'
end

scheduler.join
