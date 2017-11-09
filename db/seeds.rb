# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

pss = Digest::SHA2.hexdigest('alfredo2008')
admin = Admin.create(name: 'Alfredo', email: 'jardarubydv@gmail.com', password: pss, token: "tok_#{SecureRandom.hex(7)}", salt: SecureRandom.hex(17))