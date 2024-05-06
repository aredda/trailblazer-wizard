# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "wizard"
require "minitest/autorun"

TrailblazerWizard.configure do |config|
  config.base_directory = "test/tmp/concepts"
  config.pluralize = false
end

Minitest.after_run do
  FileUtils.rm_r(TrailblazerWizard.configuration.base_directory)
end
