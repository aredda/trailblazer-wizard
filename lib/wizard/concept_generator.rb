# frozen_string_literal: true

require "active_support/inflector"

module Wizard
  class ConceptGenerator
    attr_reader :type

    def initialize(**args)\
      @type = args[:type]
    end

    def type_dirname = Wizard.configuration.pluralize ? ActiveSupport::Inflector.pluralize(type) : type

    def generate(model, name, context = nil)
      materials = [model, type_dirname, name]
      materials.insert(1, context) unless context.nil?

      filename = materials.map { |material| ActiveSupport::Inflector.underscore(material) }.join("/")
      filename = "#{Wizard.configuration.base_directory}/#{filename}.rb"

      false if File.exist?(filename)

      content = copy(model, name, context)
      create_file(filename, content)

      filename
    end

    private

    def copy(model, name, context)
      template = File.dirname(__FILE__)
      template["lib/wizard"] = "lib/concept.txt"

      content = File.read(template)

      content["_MODEL_"] = model.camelize
      content["::_CONTEXT_"] = context.nil? ? "" : "::#{context.camelize}"
      content["_NAME_"] = name.camelize
      content["_CONCEPT_"] = type_dirname.camelize while content.include?("_CONCEPT_")

      content
    end

    def create_file(filename, content)
      FileHelper.mkdir(filename)
      File.open(filename, "w+") { |file| file.write(content) }
    end
  end
end
