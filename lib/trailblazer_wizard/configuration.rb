# frozen_string_literal: true

module TrailblazerWizard
  class Configuration
    attr_accessor :base_directory, :pluralize, :alt_types

    def initialize
      @base_directory = "app/concepts"
      @pluralize = false
      @alt_types = {}
    end
  end
end
