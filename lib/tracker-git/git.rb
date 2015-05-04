module Tracker
  class Git
    def contains?(message, options = {})
      branch = options.fetch(:branch, "HEAD")
      remote_branch = options[:remote_branch]
      result = `git log #{[remote_branch, branch].compact.join('..')} --grep='#{message}'`
      result.length > 0
    end
  end
end
