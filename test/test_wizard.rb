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
end
