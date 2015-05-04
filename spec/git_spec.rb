require 'spec_helper'

describe Tracker::Git do
  describe "#search" do
    let(:message) { "[Finishes #123456]" }
    let(:branch) { "HEAD" }
    let(:query) { "git log #{branch} --grep='#{message}'" }
    let(:result) { "Some git message" }
    let(:git) { Tracker::Git.new }

    context 'when remote branch is not used' do
      before do
        expect(git).to receive(:`).with(query) { result }
      end

      context "defaults" do
        it "searches via system calls using default branch" do
          expect(git.contains?(message)).to eq(true)
        end

        context "passing branch" do
          let(:branch) { "test" }
          it "searches via system calls using given branch" do
            expect(git.contains?(message, branch: branch)).to eq(true)
          end

          context "passing branch" do
            let(:branch) { "test" }
            it "searches via system calls using given branch" do
              expect(git.contains?(message, branch: branch)).to eq(true)
            end
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

    context "when remote brach is not blank" do
      let(:remote_branch) { 'remote/branch' }
      before { expect(git).to receive(:`).with("git log #{remote_branch}..#{branch} --grep='#{message}'") { result } }

      it "searches via system calls using geven remote and local branches" do
        git.contains?(message, branch: branch, remote_branch: remote_branch)
      end

    end


  end
end
