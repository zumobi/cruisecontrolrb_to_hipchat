
module CruisecontrolrbToHipchat
  class Hipchat
    attr_reader :client, :options
    def initialize(api_token, room, options = {})
      @options = options
      @options[:user] ||= "cruise-control"
      @options[:notify] ||= true
      @room = room
      @client = HipChat::Client.new(api_token)
    end

    def send_message(mesg, color = nil)
      client[@room].send(options[:user], mesg, {:notify => options[:notify], :color => color})
    end

  end
end