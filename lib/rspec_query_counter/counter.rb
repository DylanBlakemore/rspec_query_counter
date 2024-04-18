module RSpecQueryCounter
  module Counter

    class << self
      attr_accessor :total_query_count, :query_type_count
  
      def reset_counter!
        @total_query_count = 0
        @query_type_count = {}
      end
  
      def increment_total_count
        @total_query_count += 1
      end
  
      def increment_query_type_count(name)
        @query_type_count[name] ||= 0
        @query_type_count[name] += 1
      end
    end

  end
end
