require 'spec_helper'

describe "BlogPages" do
  
  subject { page }
  
  describe "#index" do
    before { visit blogs_path }
    
    it { should have_css('h1', text: 'Blog') }
    it { page_title(page).should == ('Blog') }
  end
end
