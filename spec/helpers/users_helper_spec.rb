require 'spec_helper'

describe UsersHelper do

  context 'when a user is signed in' do
    login_user

    it 'shoud detect not admin ' do
      expect(helper.admin?).to be_false
    end
  end

  context 'when a user is signed in' do
    login_admin

    it 'shoud detect admin ' do
      expect(helper.admin?).to be_true
    end
  end

end
