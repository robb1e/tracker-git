require 'spec_helper'

describe Tracker::Git do
  describe "#search" do
    let(:message) { "[Finishes #123456]" }
    let(:branch) { "master" }
    let(:query) { "git log --grep '#{message}' #{branch}"}
    let(:result) { "Some git message" }

    before do
      git.should_receive(:`).with(query) { result }
    end
    let(:git) { Tracker::Git.new }

    context "defaults" do
      it "searches via system calls using default branch" do
        git.contains?(message).should == true
      end
    end

    context "passing branch" do
      let(:branch) { "test" }
      it "searches via system calls using given branch" do
        git.contains?(message, branch: branch).should == true
      end
    end

    context "no result found" do
      let(:result) { "" }
      it "returns false" do
        git.contains?(message).should == false
      end
    end
  end
end
