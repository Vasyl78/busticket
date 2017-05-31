# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

station1 = Station.create(name: 'Seed1Station1')
station2 = Station.create(name: 'Seed1Station2')
station3 = Station.create(name: 'Seed1Station3')
station4 = Station.create(name: 'Seed1Station4')
station5 = Station.create(name: 'Seed1Station5')

route1 = Route.create(start_station: station1, final_station: station2, price: 25, start_date: '2017-05-22', start_time: '15:30', final_date: '2017-05-22', final_time: '16:00')
route2 = Route.create(start_station: station2, final_station: station3, price: 30, start_date: '2017-05-22', start_time: '16:05', final_date: '2017-05-22', final_time: '16:45')
route3 = Route.create(start_station: station3, final_station: station4, price: 35, start_date: '2017-05-22', start_time: '17:00', final_date: '2017-05-22', final_time: '17:50')
route4 = Route.create(start_station: station4, final_station: station5, price: 40, start_date: '2017-05-22', start_time: '18:00', final_date: '2017-05-22', final_time: '19:10')

bus1 = Bus.create(number_of_seats: 30)

journey = Journey.create(routes: [route1, route2, route3, route4], bus: bus1)

user =  User.create(email: 'test@test.com', password: 'password', password_confirmation: 'password')
admin = Admin.create(email: 'admin@test.com', password: 'adminpassword', password_confirmation: 'adminpassword')
Profile.create(first_name: 'User', last_name: 'Name', phone_number: '123456789', user: user)