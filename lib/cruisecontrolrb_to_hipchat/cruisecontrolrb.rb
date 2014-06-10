require 'httparty'
require 'nokogiri'

module CruisecontrolrbToHipchat

  class Cruisecontrolrb
    
    include HTTParty
    
    def initialize(base_url, username = nil, password = nil)
      @auth = { :username => username, :password => password }
      @base_url = base_url
    end
    
    def fetch_statuses
      options = { :basic_auth => @auth }

      noko = Nokogiri::XML(self.class.get("http://#{@base_url}/XmlStatusReport.aspx", options).parsed_response)
      projects = noko.search("Project")
      return [] unless projects.first
      
      projects.map do |project|

        status_hash = { lastBuildStatus: project["lastBuildStatus"],
                        webUrl: project["webUrl"],
                        lastBuildLabel: project["lastBuildLabel"],
                        activity: project["activity"],
                        name: project['name'] }
        status_hash
      end        
    end

  end  

end