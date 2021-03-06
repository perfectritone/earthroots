# == Schema Information
#
# Table name: blogs
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require File.dirname(__FILE__) + '/../spec_helper'

describe Blog do
  fixtures :blogs
  let(:blog) { blogs(:one)}
  subject { blog }
  
  it { should respond_to :title }
  it { should respond_to :content }
  
  it { should be_valid }
  
  specify "title should not be blank" do
    blog.title = ""
    should_not be_valid
  end
  
  specify "content should not be blank" do
    blog.content = ""
    should_not be_valid
  end
  
  specify "title should not be longer than 256 chars" do
    blog.title = "1" * 257
    should_not be_valid
  end
end
