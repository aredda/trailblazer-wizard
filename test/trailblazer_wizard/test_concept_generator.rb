# frozen_string_literal: true

require "test_helper"

module TrailblazerWizard
  class TestConceptGenerator < Minitest::Test
    def test_that_it_initializes_generator
      generator = TrailblazerWizard::ConceptGenerator.new type: TrailblazerWizard::ConceptType::OPERATION

      assert_equal TrailblazerWizard::ConceptType::OPERATION, generator.type
    end

    def test_that_it_generates_concept
      TrailblazerWizard.configuration.pluralize = false

      generator = TrailblazerWizard::ConceptGenerator.new type: TrailblazerWizard::ConceptType::OPERATION

      assert_equal "test/tmp/concepts/user/admin/operation/create.rb", generator.generate("User", "create", "Admin")

      generator = TrailblazerWizard::ConceptGenerator.new type: TrailblazerWizard::ConceptType::FINDER

      assert_equal "test/tmp/concepts/user/finder/all.rb", generator.generate("User", "All")
    end
  end
end
