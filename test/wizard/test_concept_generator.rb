# frozen_string_literal: true

require "test_helper"

module Wizard
  class TestConceptGenerator < Minitest::Test
    def test_that_it_initializes_generator
      generator = Wizard::ConceptGenerator.new type: Wizard::ConceptType::OPERATION

      assert_equal Wizard::ConceptType::OPERATION, generator.type
    end

    def test_that_it_generates_concept
      generator = Wizard::ConceptGenerator.new type: Wizard::ConceptType::OPERATION

      assert_equal "test/tmp/concepts/user/admin/operation/create.rb", generator.generate("User", "create", "Admin")

      generator = Wizard::ConceptGenerator.new type: Wizard::ConceptType::FINDER

      assert_equal "test/tmp/concepts/user/finder/all.rb", generator.generate("User", "All")
    end
  end
end
