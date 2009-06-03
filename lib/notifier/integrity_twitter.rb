require 'rubygems'
require 'integrity'
require 'twitter'

module Integrity
  class Notifier
    class IntegrityTwitter < Notifier::Base
      
      def self.notify_of_build(build, config)
        # Only send tweet when build is failed
        build.failed? ? super : true
      end
      
      def self.to_haml
        File.read File.dirname(__FILE__) / "config.haml"
      end

      def deliver!
        httpauth = Twitter::HTTPAuth.new(@config["email"], @config["pass"])
        @tweet = Twitter::Base.new(httpauth)
        @tweet.update(message) rescue nil
      end
      
      def message
        "#{build_status} | #{commit.project.name} - [committer: #{commit.author.name}] ( #{commit_url} )"
      end
      
      private
      
      def build_status
        commit.successful? ? 'GREEN' : 'FAIL!'
      end
    end
    
    register IntegrityTwitter
  end
end
