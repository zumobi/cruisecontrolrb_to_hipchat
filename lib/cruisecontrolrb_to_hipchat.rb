require "cruisecontrolrb_to_hipchat/version"
require "cruisecontrolrb_to_hipchat/cruisecontrolrb"
require "cruisecontrolrb_to_hipchat/hipchat"
require 'httparty'
require 'nokogiri'
require 'hipchat'
require 'dante'
require 'rufus-scheduler'

module CruisecontrolrbToHipchat

  class Runner
    attr_accessor :previous_statuses 
    attr_accessor :current_activities
    attr_reader :config
    
    def self.run(config)
      new(config).execute
    end

    def initialize(config)
      @config = config
      @previous_statuses = {}
      @current_activities = {}
    end

    def execute
      scheduler = Rufus::Scheduler.new(:blocking => true, :overlap => false)
      
      scheduler.every("#{config[:polling_interval]}s") do  

        statuses = Cruisecontrolrb.new(config[:cc_host], config[:cc_username], config[:cc_password]).fetch_statuses

        unless statuses.empty?     

          statuses.each do |status_hash|   
            name = status_hash[:name]
            url = File.join(status_hash[:webUrl].gsub("projects", "builds"), status_hash[:lastBuildLabel])

            if status_hash[:activity] == "Building" and current_activities[name] != "Building"
              msg = "CruiseControl has started to build project #{name}. <a href=\"#{url}\">See details</a>"
              Hipchat.new(config[:hipchat_api_token], config[:hipchat_room_id]).send_message msg
              current_activities[name] = "Building"
            elsif (current_activities[name] == "Building" and status_hash[:activity] != "Building")
              current_activities[name] = status_hash[:activity]
          
              color = (status_hash[:lastBuildStatus] == "Success") ? "green" : "red"
              message = (status_hash[:lastBuildStatus] == "Success") ? "<a href=\"#{url}\">Success</a>! #{name} is looking good. You are a stud! :D" : "You are a failure! #{name} is broken. <a href=\"#{url}\">See details</a> and fix it now! >:-(" 
              Hipchat.new(config[:hipchat_api_token], config[:hipchat_room_id]).send_message message, color
            end
          end
        end
      end

      scheduler.join
    end

  end
end
