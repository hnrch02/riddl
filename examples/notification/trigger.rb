#!/usr/bin/ruby
require '../../lib/ruby/client'
require 'socket'
require 'pp'

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

begin
  props = Riddl::Client.new("http://localhost:9292/","description.xml")

  test = props.resource("/values/state")
  status, res = test.put [
    Riddl::Parameter::Simple.new("value","stopped")
  ]
  status, res = test.get

  puts status
  p "----"
  p res
  p "----"
  res.each do |r|
    puts r.value.read if r.value.respond_to?(:read)
  end  
ensure  
  `pkill rackup`
  t.join
end
