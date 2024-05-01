# frozen_string_literal: true

module Wizard
  class Configuration
    attr_accessor :base_directory

    def initialize
      @base_directory = "app/concepts"
    end
  end
end
