$:.unshift File.join(File.dirname(__FILE__), *%w[../../lib])

require 'rubygems'
require 'erlectricity'
require 'tinder'

# domain, login, password, room_name = *ARGV
# campfire = Tinder::Campfire.new domain, :username => login, :password => password
domain, token, room_name = *ARGV
campfire = Tinder::Campfire.new domain, :token => token

#room = campfire.find_room_by_name room_name
room = campfire.rooms[1]

receive do |f|
  f.when([:speak, Any]) do |comment|
    room.speak(comment)
    f.receive_loop
  end

  f.when([:paste, Any]) do |comment|
    room.paste(comment)
    f.receive_loop
  end
  
  f.when([:listen, Any]) do
    room.listen
    f.receive_loop
  end

  f.when(Any) do |obj|
    p obj
  end
end

room.leave if room
