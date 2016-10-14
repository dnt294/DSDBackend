# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

DEFAULT_USER =  [
    {username: 'dat', email: 'dat@gmail.com', password: '123456'},
    {username: 'thuy', email: 'thuy@gmail.com', password: '123456'},
    {username: 'tu', email: 'tu@gmail.com', password: '123456'},
    {username: 'bao', email: 'bao@gmail.com', password: '123456'}
]

DEFAULT_USER.each do |user|
    User.create(user)
end

User.all.each do |user|
    Folder.create(name: 'Drive của tôi', creator_id: user.id, chat_room: ChatRoom.new)
end
