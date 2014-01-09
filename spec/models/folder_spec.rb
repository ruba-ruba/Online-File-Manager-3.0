require 'spec_helper'

describe Folder do
  let(:folder){FactoryGirl.create(:folder)}
  describe "#size" do
    it "should return size" do
      expect(folder.size).to eq(0)  
    end 
  end
end
