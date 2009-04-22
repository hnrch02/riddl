#!/usr/bin/ruby
require 'socket'

t = Thread.new do
  puts `rackup server.ru`
end  

up = false
until up
  begin
    TCPSocket.new('localhost', 9292)
    up = true
  rescue => e
    sleep 0.1
  end  
end

`php test/test.php get "/books/1/" test/book-query.txt`
`pkill rackup`
t.join
