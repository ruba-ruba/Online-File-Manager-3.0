require 'spec_helper'

describe Location do

  subject{ FactoryGirl.create(:location)}

  it "should be invalid without longitude" do
    l = FactoryGirl.build(:location, :longitude => nil)
    l .should_not be_valid
    expect(l .errors[:longitude]).to include("can't be blank")
  end

  it "should be invalid without latitude" do
    l = FactoryGirl.build(:location, :latitude => nil)
    l .should_not be_valid
    expect(l .errors[:latitude]).to include("can't be blank")
  end

end
