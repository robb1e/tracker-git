module Tracker
  class Deliverer
    attr_reader :project, :git
    def initialize(project, git)
      @project = project
      @git = git
    end

    def mark_as_delivered(branch = nil, label = nil)
      options = {}
      options[:branch] = branch if branch

      project.finished.each do |story|
        if git.contains?(story.id, options)
          project.deliver(story)
          project.add_label(story, label) if label
        end
      end
    end
  end
end
