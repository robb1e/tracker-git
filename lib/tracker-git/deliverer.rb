module Tracker
  class Deliverer
    attr_reader :project, :git
    def initialize(project, git)
      @project = project
      @git = git
    end

    def mark_as_delivered
      project.finished.each do |story|
        if git.contains?(story.id)
          project.deliver(story.id)
        end
      end
    end
  end
end
