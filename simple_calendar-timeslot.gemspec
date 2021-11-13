# frozen_string_literal: true

require_relative "lib/simple_calendar/timeslot/version"

Gem::Specification.new do |spec|
  spec.name          = "simple_calendar-timeslot"
  spec.version       = SimpleCalendar::Timeslot::VERSION
  spec.authors       = ["Kim Laplume"]
  spec.email         = ["kl@heartforge.eu"]

  spec.summary       = "TODO: Write a short summary, because RubyGems requires one."
  spec.description   = "TODO: Write a longer description or delete this line."
  spec.homepage      = "https://github.com/1klap/simple_calendar-timeslot"
  spec.required_ruby_version = ">= 2.4.0"

  spec.metadata["allowed_push_host"] = "TODO: Set to 'https://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/1klap/simple_calendar-timeslot"
  spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency gem 'simple_calendar', '~> 2.0'

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
