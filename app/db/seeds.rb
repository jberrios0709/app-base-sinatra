require_relative '../lib/configuration'

admin = Models::Role.create!(
  name: 'Administrador',
  active: 1
)

Models::Role.create!(
  name: 'User',
  active: 1
)

user = Models::User.create!(
  username: 'josealbertoberrios_15@gmail.com',
  password: 'password1234',
  role: admin
)

Models::Profile.create!(
    first_name: 'jose',
    last_name: 'berrios',
    cellphone: '1137882989',
    user: user
)