require 'spec_helper'

describe Tracker::Project do

  let(:tracker_token) { stub }
  let(:project_id) { stub }
  let(:the_project) { stub }
  let(:feature) { stub }
  let(:bug) { stub }

  describe "#initialize" do
    it "initializes the project class" do
      project = Tracker::Project.new(tracker_token, project_id)
      project.should be
      project.tracker_token.should == tracker_token
      project.project_id.should == project_id
    end
  end

  describe ".finished" do

    let(:query) { stub }

    before do
      PivotalTracker::Project.should_receive(:find).with(project_id) { the_project }
      the_project.should_receive(:stories) { query }
      query.should_receive(:all).with(state: "finished", story_type: ['bug', 'feature']) { [feature, bug] }
    end

    it "retrieves finished stories and bugs" do
      project = Tracker::Project.new(tracker_token, project_id)
      project.finished.should == [feature, bug]
    end

  end
end
