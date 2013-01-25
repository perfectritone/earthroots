admin = User.find_or_create_by_name!(
   "admin",
   email: "addiem@gmail.com",
   password: "password",
   password_confirmation: "password"
) { |u| u.toggle!(:admin) }
