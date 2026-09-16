User.find_or_create_by!(email: 'admin@store.com') do |user|
  user.first_name = 'Адміністратор'
  user.last_name = 'Системи'
  user.password = 'password123'
  user.password_confirmation = 'password123'
  user.role = :admin
end

puts "Admin seed: admin@store.com / password123"

cat_windows = Category.find_or_create_by!(name: 'Вікна') { |c| c.description = 'Металопластикові та алюмінієві вікна' }
cat_doors = Category.find_or_create_by!(name: 'Двері') { |c| c.description = 'Вхідні та міжкімнатні дверні конструкції' }
cat_hardware = Category.find_or_create_by!(name: 'Фурнітура') { |c| c.description = 'Ручки, замки та комплектуючі' }

Product.find_or_create_by!(sku: 'WIN-STD-01') do |p|
  p.name = 'Вікно двостулкове Rehau 70'
  p.category = cat_windows
  p.price = 4500.00
  p.stock = 15
  p.description = 'Стандартне енергоощадне двокамерне вікно для квартири.'
end

Product.find_or_create_by!(sku: 'DOOR-STEEL-01') do |p|
  p.name = 'Двері вхідні броньовані "Фортеця"'
  p.category = cat_doors
  p.price = 12800.00
  p.stock = 5
  p.description = 'Посилена сталева конструкція з терморозривом та надійними замками.'
end

Product.find_or_create_by!(sku: 'HARD-ROTO-01') do |p|
  p.name = 'Ручка віконна Roto Swing'
  p.category = cat_hardware
  p.price = 320.00
  p.stock = 40
  p.description = 'Оригінальна алюмінієва віконна ручка з фіксатором.'
end

puts "Catalog seeded successfully!"