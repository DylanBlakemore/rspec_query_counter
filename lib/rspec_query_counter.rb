require_relative "rspec_query_counter/version"
require_relative "rspec_query_counter/counter"
require "active_support/notifications"

module RSpecQueryCounter
  class << self
    def setup(config)
      counter = RSpecQueryCounter::Counter

      config.before(:suite) do
        counter.reset_counter!
      end
    
      config.around(:each) do |example|
        counter_f = RSpecQueryCounter.counter_function(counter)
        ActiveSupport::Notifications.subscribed(counter_f, "sql.active_record") do
          example.run
        end
      end
    
      config.after(:suite) do
        RSpecQueryCounter.print_results(counter)
        counter.reset_counter!
      end
    end

    def query_type(payload_name)
      RSpecQueryCounter.presence(payload_name&.split(" ")&.drop(1)&.join(" ")) ||
        RSpecQueryCounter.presence(payload_name) ||
        "Unknown"
    end

    def print_results(counter)
      puts "\nTotal number of database queries: #{counter.total_query_count}"

      puts "Queries by type:"
      counter.query_type_count.each do |type, count|
        puts "#{type}: #{count}"
      end
    end

    def counter_function(counter)
      lambda do |_name, _started, _finished, _unique_id, payload|
        unless ["CACHE", "SCHEMA"].include?(payload[:name])
          counter.increment_total_count
          query_type = RSpecQueryCounter.query_type(payload[:name])
          counter.increment_query_type_count(query_type)
        end
      end
    end

    def presence(value)
      return nil if value.nil? || value.empty?
      return value
    end
  end
end
