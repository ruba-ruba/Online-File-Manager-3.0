require 'spec_helper'

describe Comment do

  subject{ FactoryGirl.create(:folder_comment_with_votes, :negative_votes => 1, :positive_votes => 2) }

  describe '#update_counters' do
    it 'should update counters' do
      expect(subject.votes_up).to eq(0)
      expect(subject.votes_down).to eq(0)

      subject.update_counters

      expect(subject.votes_up).to eq(2)
      expect(subject.votes_down).to eq(1)
    end

    it 'should store correct values' do
      subject.update_counters
      5.times { FactoryGirl.create(:vote, :comment => subject, :vote_type => true) }
      expect{subject.update_counters}.to change(subject, :votes_up).by(5)
    end
  end

  describe '#author' do
    it 'should be anonimous if user has no name' do
      expect(subject.author).to eq "anonymous"
    end
    it 'should show name if user has name' do
      u = subject.user
      u.update_attribute(:name, 'John Doe')
      expect(subject.author).to eq "John Doe"
    end
  end
end
