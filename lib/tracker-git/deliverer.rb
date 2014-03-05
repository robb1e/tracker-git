module Tracker
  class Deliverer
    attr_reader :project, :git
    def initialize(project, git)
      @project = project
      @git = git
    end

    def mark_as_delivered(branch = nil,remote_branch= nil, label = nil, use_accepted = false, server_name = nil)
      options = {}
      options[:branch] = branch if branch
      options[:remote_branch] = remote_branch if remote_branch

      collection = use_accepted ? project.delivered : project.finished

      collection.each do |story|
        if git.contains?(story.id, options)
          project.accept(story) if use_accepted
          project.deliver(story) unless use_accepted
          project.add_label(story, label) if label
          project.comment(story, server_name) if server_name
        end
      end
    end

    def mark_as_accepted(branch = nil,remote_branch = nil, label = nil)
      mark_as_delivered(branch, remote_branch, label, true)
    end
  end
end
