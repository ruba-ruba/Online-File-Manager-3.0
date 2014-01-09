require 'spec_helper'

describe "Comments" do

  login_user

  describe "GET /comments" do
    it "should render comments" do
      comment = FactoryGirl.create :folder_comment_with_votes, :content => "a very useful Comment"
      folder = comment.commentable
      comment.update_counters
      visit folder_comments_path(folder)
      page.should have_content("a very useful Comment")
    end
  end
end
