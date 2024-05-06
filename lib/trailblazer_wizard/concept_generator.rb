# frozen_string_literal: true

require "active_support/inflector"

module TrailblazerWizard
  class ConceptGenerator
    attr_reader :type

    def initialize(**args)\
      @type = args[:type]
    end

    def true_type = (TrailblazerWizard.configuration.alt_types[type.to_sym] || type).to_s

    def type_dirname = TrailblazerWizard.configuration.pluralize ? ActiveSupport::Inflector.pluralize(true_type) : true_type

    def generate(model, name, context = nil)
      materials = [model, type_dirname, name]
      materials.insert(1, context) unless context.nil?

      filename = materials.map { |material| ActiveSupport::Inflector.underscore(material) }.join("/")
      filename = "#{TrailblazerWizard.configuration.base_directory}/#{filename}.rb"

      false if File.exist?(filename)

      content = copy(model, name, context)
      create_file(filename, content)

      filename
    end

    private

    def copy(model, name, context)
      template = File.dirname(__FILE__)
      template["lib/trailblazer_wizard"] = "lib/concept.txt"

      content = File.read(template)

      content["_MODEL_"] = model.camelize
      content["::_CONTEXT_"] = context.nil? ? "" : "::#{context.camelize}"
      content["_NAME_"] = name.camelize
      content["_CONCEPT_"] = type_dirname.camelize
      content["_CONCEPT_"] = true_type.camelize

      content
    end

    def create_file(filename, content)
      FileHelper.mkdir(filename)
      File.open(filename, "w+") { |file| file.write(content) }
    end
  end
end
