require 'spec_helper'

describe VotesController do

  login_user

  describe "GET 'vote'" do
    let(:comment){FactoryGirl.create(:folder_comment)}
    let(:vote){FactoryGirl.create(:vote)}
    it "should make a vote" do
      post :vote, {:comment_id => comment.id, :vote_type => true, :format => :js}
      expect(response).to be_success
    end
  end

end
