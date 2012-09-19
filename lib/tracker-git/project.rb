module Tracker
  class Project

    attr_reader :tracker_token, :project_id

    def initialize(tracker_token, project_id)
      @tracker_token = tracker_token
      @project_id = project_id
    end

    def finished
      _project.stories.all(state: "finished", story_type: ['bug', 'feature'])
    end

    private
    def _project
      @project ||= PivotalTracker::Project.find(project_id)
    end
  end
end
