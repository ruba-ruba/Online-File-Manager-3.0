require 'spec_helper'

describe "comments/show" do
  before(:each) do
    @comment = assign(:comment, stub_model(Comment,
      :content => "MyText",
      :commentable_id => 1,
      :commentable_type => "Commentable Type",
      :user_id => "User",
      :string => "String"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    rendered.should match(/1/)
    rendered.should match(/Commentable Type/)
    rendered.should match(/User/)
    rendered.should match(/String/)
  end
end
