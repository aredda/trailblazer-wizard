# frozen_string_literal: true

require_relative 'wizard/version'
require_relative 'wizard/concept_type'
require_relative 'wizard/concept_generator'

module Wizard
  def self.generate(model)
    "Generating #{model} concept files..."
  end
end
