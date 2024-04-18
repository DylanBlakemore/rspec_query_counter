require_relative 'lib/rspec_query_counter/version'

Gem::Specification.new do |spec|
  spec.name          = "rspec_query_counter"
  spec.version       = RSpecQueryCounter::Version::VERSION
  spec.authors       = ["Dylan Blakemore"]
  spec.email         = ["dylan.blakemore@gmail.com"]

  spec.summary       = "Keep track of the number of queries in your RSpec tests."
  spec.description   = "Keeps track of the number and type of queries in your RSpec tests and provides a summary at the end of the test run."
  spec.homepage      = "https://github.com/DylanBlakemore/rspec_query_counter"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/DylanBlakemore/rspec_query_counter"
  spec.metadata["changelog_uri"] = "https://github.com/DylanBlakemore/rspec_query_counter/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
