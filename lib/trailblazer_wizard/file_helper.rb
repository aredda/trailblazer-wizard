# frozen_string_literal: true

require "fileutils"

module TrailblazerWizard
  class FileHelper
    def self.mkdir(filename)
      dirs = filename.split "/"

      composite = []
      (dirs - [dirs.last]).each do |dir|
        composite << dir

        next if File.exist?(composite.join("/"))

        FileUtils.mkdir(composite.join("/"))
      end
    end
  end
end
