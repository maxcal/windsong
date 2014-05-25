# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

admin = User.with(
    email: "admin@example.com",
    password: "kitekite",
    password_confirmation: "kitekite"
).find_or_create_by(username: "admin")

admin.add_role(:admin)
admin.confirm!