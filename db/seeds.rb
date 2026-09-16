User.find_or_create_by!(email: 'admin@store.com') do |user|
  user.first_name = 'Адміністратор'
  user.last_name = 'Системи'
  user.password = 'password123'
  user.password_confirmation = 'password123'
  user.role = :admin
end

puts "Admin seed: admin@store.com / password123"