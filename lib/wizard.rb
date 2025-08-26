# frozen_string_literal: true

require_relative "trailblazer_wizard/version"
require_relative "trailblazer_wizard/concept_type"
require_relative "trailblazer_wizard/concept_generator"
require_relative "trailblazer_wizard/file_helper"
require_relative "trailblazer_wizard/configuration"

module TrailblazerWizard
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

    return generate_full(model, **args) if args.key?(:full) && args[:full]

    raise StandardError, "[actions] arg is required" unless args.key? :actions

    concepts = ConceptType::ALL.values
    actions = args[:actions]

    concepts -= args[:except] if args.key? :except
    concepts = args[:only]    if args.key? :only

    output = []

    actions.each do |action|
      concepts.each do |concept|
        file = fetch_generator(concept.to_s).generate(model, action.to_s, args[:context]&.to_s)
        output << file if file.length.positive?
      end
    end

    puts output

    output
  end

  def self.generate_full(model, **args)
    batch = {
      operation: %w[index show create update destroy],
      form: %w[create update],
      finder: %w[base],
      view: %w[index show]
    }

    batch.each_key do |concept|
      batch[concept].each do |action|
        file = fetch_generator(concept.to_s).generate(model, action.to_s, args[:context]&.to_s)

        puts file if file.length.positive?
      end
    end
  end
end
