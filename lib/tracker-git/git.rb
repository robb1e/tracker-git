module Tracker
  class Git
    def contains?(message, options = {})
      branch = options.fetch(:branch, "HEAD")
      result = `git log #{branch} --grep='#{message}'`
      result.length > 0
    end
  end
end
