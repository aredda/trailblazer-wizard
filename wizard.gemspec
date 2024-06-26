# frozen_string_literal: true

require_relative "lib/trailblazer_wizard/version"

Gem::Specification.new do |spec|
  spec.name = "trailblazer-wizard"
  spec.version = TrailblazerWizard::VERSION
  spec.authors = ["aredda"]
  spec.email = ["aredda.ibrahim@gmail.com"]

  spec.summary = "Generator for Trailblazer concept files."
  spec.description = "A gem that will help you generate concept files for Trailblazer more easily and quickly."
  spec.homepage = "https://www.github.com/aredda/trailblazer-wizard"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://www.github.com/aredda/trailblazer-wizard"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.executables = "wizard"
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "activesupport"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
