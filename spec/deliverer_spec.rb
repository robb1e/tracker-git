require 'spec_helper'

describe Tracker::Deliverer do

  let(:tracker_token) { stub }
  let(:project_id) { stub }
  let(:commited_story) { stub(id: 1) }
  let(:uncommited_story) { stub(id: 2) }
  let(:finished_stories) { [commited_story, uncommited_story] }
  let(:project) { stub }
  let(:git) { stub }
  let(:deliverer) { Tracker::Deliverer.new(project, git) }

  describe '#mark_as_delivered' do
    context 'when called without argument' do
      it('should mark stories as delivered') do
        project.should_receive(:finished) { finished_stories }
        git.should_receive(:contains?).with(1, {}) { true }
        git.should_receive(:contains?).with(2, {}) { false }
        project.should_receive(:deliver).with(commited_story)
        project.should_not_receive(:deliver).with(uncommited_story)

        deliverer.mark_as_delivered
      end
    end

    context 'when given a specific branch' do
      it('should mark stories as delivered') do
        project.should_receive(:finished) { finished_stories }
        git.should_receive(:contains?).with(1, {branch: 'develop'}) { true }
        git.should_receive(:contains?).with(2, {branch: 'develop'}) { false }
        project.should_receive(:deliver).with(commited_story)
        project.should_not_receive(:deliver).with(uncommited_story)

        deliverer.mark_as_delivered('develop')
      end
    end
  end

end
