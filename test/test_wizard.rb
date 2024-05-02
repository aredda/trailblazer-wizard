# frozen_string_literal: true

require "test_helper"

class TestWizard < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Wizard::VERSION
  end

  def test_that_it_requires_actions_arg
    error = assert_raises StandardError do
      Wizard.generate("User")
    end

    assert_equal "[actions] arg is required", error.message
  end

  def test_that_it_generates_files
    Wizard.configure do |config|
      config.alt_types = {}
      config.pluralize = false
    end

    Wizard.generate("User", actions: %w[create update], only: %w[operation form])

    assert File.exist?("test/tmp/concepts/user/operation/create.rb")
    assert File.exist?("test/tmp/concepts/user/operation/update.rb")
    assert File.exist?("test/tmp/concepts/user/form/create.rb")
    assert File.exist?("test/tmp/concepts/user/form/update.rb")

    Wizard.generate("User::Document", actions: %i[index show], only: %i[operation view], context: :admin)

    assert File.exist?("test/tmp/concepts/user/document/admin/operation/index.rb")
    assert File.exist?("test/tmp/concepts/user/document/admin/operation/show.rb")
    assert File.exist?("test/tmp/concepts/user/document/admin/view/index.rb")
    assert File.exist?("test/tmp/concepts/user/document/admin/view/show.rb")
  end

  def test_that_it_pluralize_concept_directories
    Wizard.configure do |config|
      config.pluralize = true
    end

    Wizard.generate("Category", actions: %i[create], only: %i[operation])

    assert File.exist?("test/tmp/concepts/category/operations/create.rb")
  end

  def test_that_it_uses_alt_types
    Wizard.configure do |config|
      config.alt_types = {
        view: :representable
      }
      config.pluralize = false
    end

    Wizard.generate("Application", actions: %w[index], only: %w[view])

    assert File.exist?("test/tmp/concepts/application/representable/index.rb")
  end
end
