module Tracker
  class Deliverer
    attr_reader :project, :git
    def initialize(project, git)
      @project = project
      @git = git
    end

    def mark_as_delivered(branch = nil, label = nil, use_accepted = false)
      options = {}
      options[:branch] = branch if branch

      collection = use_accepted ? project.delivered : project.finished

      collection.each do |story|
        if git.contains?(story.id, options)
          project.accept(story) if use_accepted
          project.deliver(story) unless use_accepted
          project.add_label(story, label) if label
        end
      end
    end

    def mark_as_accepted(branch = nil, label = nil)
      mark_as_delivered(branch, label, true)
    end
  end
end
