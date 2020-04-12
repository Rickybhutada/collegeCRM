# Create Course type from the constant value defined
COURSE_TYPE.each do |course|
  CourseType.find_or_create_by({name: course[:name]})
end


# Create User Account with Admin role
# set password to "admin123"
User.find_or_create_by(email: 'admin@gmail.com') do |user|
  user.password = 'admin123'
  user.number = '123456789'
  user.name = 'Admin'
  user.save
  user.create_user_role(role_id: ADMIN)
end

