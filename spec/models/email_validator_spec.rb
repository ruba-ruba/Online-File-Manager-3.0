require 'spec_helper'

describe EmailValidator do

  it 'should validate an email format' do
    params = {:recipient => "admin@example.com", :subject => "s"}
    expect(EmailValidator.new(params)).to be_valid
  end

  it 'should validate an email presence' do
    params = {:recipient => "", :subject => "s"}
    expect(EmailValidator.new(params)).not_to be_valid
  end

  it 'should validate subject presence' do
    params = {:recipient => "admin@example.com", :subject => ""}
    expect(EmailValidator.new(params)).not_to be_valid
  end
end