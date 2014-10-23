#!/usr/bin/env ruby

require 'rubygems'
require 'ffi-rzmq'

require './message_handler.rb'

ip = "10.1.3.109"
port = "31285"

message_sub = MessageHandler::MessageSubscriber.new
message_sub.create_subscriber(ip, port)

loop do
  puts "...waiting for incoming message..."
  message_sub.recv_message()
end
