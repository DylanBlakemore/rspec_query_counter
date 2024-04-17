require "spec_helper"

RSpec.describe RspecQueryCounter::Counter do
  before do
    described_class.reset_counter!
  end

  it "increments the total query count" do
    expect(described_class.total_query_count).to eq(0)
    described_class.increment_total_count
    expect(described_class.total_query_count).to eq(1)
  end

  it "increments the query type count" do
    expect(described_class.query_type_count).to eq({})
    described_class.increment_query_type_count("SELECT")
    expect(described_class.query_type_count).to eq("SELECT" => 1)
    described_class.increment_query_type_count("SELECT")
    expect(described_class.query_type_count).to eq("SELECT" => 2)
  end
end

