admin = User.find_or_create_by_name!(
   "admin",
   email: "addiem@gmail.com",
   password: "password",
   password_confirmation: "password"
) { |u| u.toggle!(:admin) }

Link.find_or_create_by_name!(
  "Mountain Rose Herbs",
  category: "Herbs",
  address: "http://www.mountainroseherbs.com"
)
Link.find_or_create_by_name!(
  "Frontier Co-op",
  category: "Herbs",
  address: "http://www.frontiercoop.com/"
)
Blog.find_or_create_by_title!(
  "Learn about Fennel!",
  content: "Fennel belongs to the carrot family and the seed has a variety of medicinal uses. It's sweet tase makes it a palatable and delightful remedy. Fennel seed has been used widely as a carminative and digestive aid. It can relieve mild digestive cramps, bloating, flatulence, indigestion, diarrhea and stomach ache. It is especially useful for colic in babies and children. Fennel seeds are anti microbial and antifungal, demonstrating effectiveness against staphylococcus aureus, salmonella typhimurium and Candida albicans. Fennel is indicated for upper respiratory catarrh, coughs, bronchitis, and inflammation of the mouth and throat. It also increases healthy milk production in lactating women. Fennel tea can be used as a soothing eyewash for conjunctivitis, inflammation and itchy eyes.
)
