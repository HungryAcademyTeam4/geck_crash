HOST_IP = '192.168.1.30'
require 'redis'
redis = Redis.new(:host => HOST_IP, :port => 6379)

chat_line = ""
until chat_line == "quit" do
  chat_line = gets.chomp
  redis.publish("channel1", chat_line)
end
