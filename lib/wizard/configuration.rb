# frozen_string_literal: true

module Wizard
  class Configuration
    attr_accessor :base_directory, :pluralize

    def initialize
      @base_directory = "app/concepts"
      @pluralize = false
    end
  end
end
