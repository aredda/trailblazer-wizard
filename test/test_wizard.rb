# frozen_string_literal: true

require "test_helper"

class TestWizard < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Wizard::VERSION
  end

  def test_that_it_generates_concept_files
    assert_equal "Generating User concept files...", Wizard.generate("User")
  end
end
