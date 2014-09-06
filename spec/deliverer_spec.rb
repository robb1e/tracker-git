require 'spec_helper'

describe Tracker::Deliverer do

  let(:tracker_token) { double }
  let(:project_id) { double }
  let(:commited_story) { double(id: 1) }
  let(:uncommited_story) { double(id: 2) }
  let(:finished_stories) { [commited_story, uncommited_story] }
  let(:project) { double }
  let(:git) { double }
  let(:deliverer) { Tracker::Deliverer.new(project, git) }

  describe '#mark_as_delivered' do
    context 'when called without argument' do
      it('should mark stories as delivered') do
        expect(project).to receive(:finished) { finished_stories }
        expect(git).to receive(:contains?).with(1, {}) { true }
        expect(git).to receive(:contains?).with(2, {}) { false }
        expect(project).to receive(:deliver).with(commited_story)
        expect(project).to_not receive(:deliver).with(uncommited_story)

        deliverer.mark_as_delivered
      end
    end

    context 'when given a specific branch' do
      it('should mark stories as delivered') do
        expect(project).to receive(:finished) { finished_stories }
        expect(git).to receive(:contains?).with(1, {branch: 'develop'}) { true }
        expect(git).to receive(:contains?).with(2, {branch: 'develop'}) { false }
        expect(project).to receive(:deliver).with(commited_story)
        expect(project).to_not receive(:deliver).with(uncommited_story)

        deliverer.mark_as_delivered('develop')
      end
    end

    context 'when given a label to add' do
      it('should mark stories as delivered and add a label') do
        expect(project).to receive(:finished) { finished_stories }
        expect(git).to receive(:contains?).with(1, {}) { true }
        expect(git).to receive(:contains?).with(2, {}) { false }
        expect(project).to receive(:deliver).with(commited_story)
        expect(project).to_not receive(:deliver).with(uncommited_story)
        expect(project).to receive(:add_label).with(commited_story, 'label')
        expect(project).to_not receive(:add_label).with(uncommited_story, 'label')

        deliverer.mark_as_delivered(nil, 'label')
      end
    end
  end

end
