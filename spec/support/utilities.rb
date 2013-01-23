def page_title(page)
  page.html.match(/<title>(.*)<\/title>/m)[1].to_s.strip
end
