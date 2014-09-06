require 'spec_helper'

describe Tracker::Git do
  describe "#search" do
    let(:message) { "[Finishes #123456]" }
    let(:branch) { "HEAD" }
    let(:query) { "git log #{branch} --grep='#{message}'"}
    let(:result) { "Some git message" }

    before do
      expect(git).to receive(:`).with(query) { result }
    end
    let(:git) { Tracker::Git.new }

    context "defaults" do
      it "searches via system calls using default branch" do
        expect(git.contains?(message)).to eq(true)
      end
    end

    context "passing branch" do
      let(:branch) { "test" }
      it "searches via system calls using given branch" do
        expect(git.contains?(message, branch: branch)).to eq(true)
      end
    end

    context "no result found" do
      let(:result) { "" }
      it "returns false" do
        expect(git.contains?(message)).to eq(false)
      end
    end
  end
end
