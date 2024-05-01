# frozen_string_literal: true

require_relative "wizard/version"
require_relative "wizard/concept_type"
require_relative "wizard/concept_generator"
require_relative "wizard/file_helper"
require_relative "wizard/configuration"

module Wizard
  def self.generate(model)
    "Generating #{model} concept files..."
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure(&block)
    yield(configuration)
  end
end
