require 'spec_helper'

describe "duplicates/index" do
  before(:each) do
    assign(:duplicates, [
      stub_model(Duplicate,
        :item => nil
      ),
      stub_model(Duplicate,
        :item => nil
      )
    ])
  end

  it "renders a list of duplicates" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
