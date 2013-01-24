# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  password_digest :string(255)
#  remember_token  :string(255)
#  admin           :boolean          default(FALSE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require File.dirname(__FILE__) + '/../spec_helper'

describe User do
  before do
    @user = FactoryGirl.create(:user)
  end
  
  subject { @user }
  
  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:admin) }
  
  describe "when the User has valid parameters" do
    it { should be_valid }
  end
  
  describe "when e-mail is an invalid pattern, no TLD" do
    before { @user.email = "naaaanaaaa@notopleveldomain" }
    it { should_not be_valid }
  end
  
  describe "when e-mail is an invalid pattern, no @ sign" do
    before { @user.email = "naaaanaaaa" }
    it { should_not be_valid }
  end
  
  describe "when e-mail is an invalid pattern, no @ sign" do
    before { @user.email = "naaaanaaaa.com" }
    it { should_not be_valid }
  end
  
  describe "when e-mail is an invalid pattern, nothing before @" do
    before { @user.email = "@this.com" }
    it { should_not be_valid }
  end
  
  describe "when e-mail is not all lowercase" do
    let(:mixed_case_email) { "FoO@baR.COM" }
    
    it "should be converted to lowercase before entering the db" do
      @user.email = mixed_case_email
      @user.save
      @user.reload.email.should == mixed_case_email.downcase
    end
  end
  
  describe "when password hasn't been entered" do
    before { @user.password = @user.password_confirmation = "" }
    it { should_not be_valid }
  end
  
  describe "when password is too short" do
    before { @user.password = @user.password_confirmation = "12345" }
    it { should_not be_valid }
  end
  
  describe "when password confirmation doesn't match" do
    before { @user.password_confirmation = "testung" }
    it { should_not be_valid }
  end
  
  describe "when password confirmation does not exist (can't happen in browser)" do
    before { @user.password_confirmation = nil }
    it { should_not be_valid }
  end
  
  describe "remember token" do
    its(:remember_token) { should_not be_blank }
  end
  
  describe "when the e-mail address is already taken" do
    it do
      expect do
        FactoryGirl.create(:user, email: @user.email)
      end.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
  
  it { should_not be_admin }
  
  describe "with admin privileges" do
    before { @user.toggle(:admin) }
    it { should be_admin }
  end
  
  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by_email(@user.email) }

    describe "with valid password" do
      it { should == found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not == user_for_invalid_password }
      specify { user_for_invalid_password.should be_false }
    end
end
end
