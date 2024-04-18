require "spec_helper"

RSpec.describe RspecQueryCounter do
  describe ".query_type" do
    it "returns the query type when the payload name consists of a model and query" do
      expect(RspecQueryCounter.query_type("FooModel Load")).to eq("Load")
    end

    it "returns the query type when the payload name has a multi-word query" do
      expect(RspecQueryCounter.query_type("FooModel Bulk Insert")).to eq("Bulk Insert")
    end

    it "returns the query type when the payload name is TRANSACTION" do
      expect(RspecQueryCounter.query_type("TRANSACTION")).to eq("TRANSACTION")
    end

    it "returns Unknown when the payload name is empty" do
      expect(RspecQueryCounter.query_type("")).to eq("Unknown")
    end
  end

  describe ".print_results" do
    it "prints the total query count and queries by type" do
      counter = double("Counter", total_query_count: 2, query_type_count: { "SELECT" => 1, "INSERT" => 1 })
      expect { RspecQueryCounter.print_results(counter) }.to output("\nTotal number of database queries: 2\nQueries by type:\nSELECT: 1\nINSERT: 1\n").to_stdout
    end
  end

  describe ".counter_function" do
    it "returns a lambda that increments the total query count and query type count" do
      counter = double("Counter")
      lambda = RspecQueryCounter.counter_function(counter)
      payload = { name: "FooModel Load" }

      expect(counter).to receive(:increment_total_count)
      expect(counter).to receive(:increment_query_type_count).with("Load")
      lambda.call("sql.active_record", Time.now, Time.now, "123", payload)
    end

    it "does not increment the total query count and query type count for CACHE and SCHEMA queries" do
      counter = double("Counter")
      lambda = RspecQueryCounter.counter_function(counter)
      payload = { name: "CACHE" }

      expect(counter).not_to receive(:increment_total_count)
      expect(counter).not_to receive(:increment_query_type_count)
      lambda.call("sql.active_record", Time.now, Time.now, "123", payload)
    end
  end

  describe ".setup" do
    it "resets the counter before the suite, runs the example with the counter function, and prints the results after the suite" do
      config = double("Config")
      example = double("Example")

      expect(config).to receive(:before).with(:suite)
      expect(config).to receive(:around).and_yield(example)
      expect(config).to receive(:after).with(:suite)
      expect(RspecQueryCounter).to receive(:counter_function).with(RspecQueryCounter::Counter).and_return("counter_function")
      expect(ActiveSupport::Notifications).to receive(:subscribed).with("counter_function", "sql.active_record")

      RspecQueryCounter.setup(config)
    end
  end
end
