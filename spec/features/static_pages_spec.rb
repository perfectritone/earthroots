require 'spec_helper'

describe "StaticPages" do
  
  subject { page }
  
  describe "Home page" do
    before { visit root_path }
    
    it { should have_content('StaticPages#index') }
    #it { should have_selector('title', text: full_title ) }
  end

  describe "Contact page" do
    before { visit contact_path }
    
    it { should have_content('StaticPages#contact') }
    #it { should have_selector('title', text: 'Contact') }
  end
  
  describe "Shop page" do
    before { visit shop_path }
    
    it { should have_content('StaticPages#shop') }
    #it { should have_selector('title', text: 'Contact') }
  end
end
