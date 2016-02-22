# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Role.create(name: "Administrador", is_admin: true)
Role.create(name: "Cliente", is_client: true)

User.new(name: "Admin", last_name: "User", address_1: "calle", address_2: "lugar", zip_code: "1234", email: "alfre@sad.com", cellphone: "478324",role_id: 1, country:  "mexico", username: "admin", password: "administrator", password_confirmation: "administrator").save(validate: false)