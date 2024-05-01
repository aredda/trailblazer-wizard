# frozen_string_literal: true

require_relative "wizard/version"
require_relative "wizard/concept_type"
require_relative "wizard/concept_generator"
require_relative "wizard/file_helper"
require_relative "wizard/configuration"

module Wizard
  def self.pool
    @pool ||= {}
  end

  def self.fetch_generator(type)
    pool[type] ||= ConceptGenerator.new(type: type)
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end

  def self.generate(model, **args)
    raise StandardError, "[model] arg is required" if model.nil?

    raise StandardError, "[actions] arg is required" unless args.key? :actions

    concepts = ConceptType::ALL.values
    actions = args[:actions]

    concepts -= args[:except] if args.key? :except
    concepts = args[:only]    if args.key? :only

    actions.each do |action|
      concepts.each do |concept|
        fetch_generator(concept.to_s).generate(model, action.to_s, args[:context]&.to_s)
      end
    end
  end
end
