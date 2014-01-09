require 'spec_helper'

describe VotesController do

  login_user

  describe "GET 'vote'" do
    let(:comment){FactoryGirl.create(:folder_comment)}
    let(:vote){FactoryGirl.create(:vote)}
    it "should make a vote" do
      get :vote, {:vote_type => 'true', :comment_id => comment.id}
      expect(response).not_to be_success
    end
  end

end
