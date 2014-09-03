require 'pivotal-tracker'

module Tracker
  class Project

    attr_reader :tracker_token, :project_id

    def initialize(tracker_token, project_id)
      @tracker_token = tracker_token
      @project_id = project_id

      PivotalTracker::Client.token = tracker_token
      PivotalTracker::Client.use_ssl = true
    end

    def finished
      _project.stories.all(state: "finished", story_type: ['bug', 'feature'])
    end

    def delivered
      _project.stories.all(state: "delivered", story_type: ['bug', 'feature'])
    end

    def deliver(story)
      story.update(current_state: "delivered")
    end

    def accept(story)
      story.update(current_state: "accepted")
    end

    def add_label(story, label)
      labels = (story.labels || "").split(",")
      labels << label
      story.update(labels: labels.join(","))
    end

    private
    def _project
      @project ||= PivotalTracker::Project.find(project_id)
    end
  end
end
