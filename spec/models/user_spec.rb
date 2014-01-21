require 'spec_helper'

describe User do

  describe "#expired?" do
    let(:user){FactoryGirl.create(:user_wiht_expires)}
    it "expires_at is false" do
      expect(user.expired?).to eq(true)
    end
  end

  describe "#generate_token" do
    let(:user){FactoryGirl.create(:user)}
    it "expires_at is false" do
      expect(user.expired?).to eq(false)
    end

    it "toren not be nil" do
      expect(user.send :generate_token).should_not be_nil
    end

    it "return true toren" do
      old_token = user.token
      user.send :generate_token
      expect(user.token).not_to eq(old_token)
    end
  end

  describe "#set_expiration" do
    let(:user){FactoryGirl.create(:user)}
    it "return expires_at" do
      expect(user.send :set_expiration).should_not be_nil
    end
    it "return expires_at" do
      expect(user.expires_at.to_date).to eq((DateTime.now+365).to_date)
    end
  end
end
