require 'spec_helper'

describe Tracker::Deliverer do

  let(:tracker_token) { stub }
  let(:project_id) { stub }
  let(:finished_stories) { [stub(id: 1), stub(id: 2)] }
  let(:project) { stub }
  let(:git) { stub }
  let(:deliverer) { Tracker::Deliverer.new(project, git) }

  describe "mark_as_delivered" do
    it("should mark stories as delivered") do
      project.should_receive(:finished) { finished_stories }
      git.should_receive(:contains?).with(1) { true }
      git.should_receive(:contains?).with(2) { false }
      project.should_receive(:deliver).with(1)

      deliverer.mark_as_delivered
    end
  end

end
