require 'rubygems'
require 'integrity'
require 'twitter'

module Integrity
  class Notifier
    class IntegrityTwitter < Notifier::Base
      
      def self.to_haml
        File.read File.dirname(__FILE__) / "config.haml"
      end

      def deliver!
        p @config["email"]
        p @config["pass"]
        httpauth = Twitter::HTTPAuth.new(@config["email"], @config["pass"])
        @tweet = Twitter::Base.new(httpauth)
        @tweet.update(short_message)
      end
      
    end
  end
end
