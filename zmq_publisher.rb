#!/usr/bin/env ruby

require 'rubygems'
require 'ffi-rzmq'
require './message_handler.rb'

ip = "10.1.3.109"
port = "31285"

msg_pub = MessageHandler::MessagePublisher.new
msg_pub.create_publisher(ip, port)
cnt = 0

while (1) do
  msg = "Hello " + cnt.to_s
  msg_pub.send_message(msg)
  cnt = cnt+1
  sleep(1)
end