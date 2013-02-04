module BlogsHelper

  def display_content (content)
    simple_format(content, {}, paragraph: false )
  end
  
end
