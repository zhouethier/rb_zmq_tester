#!/usr/bin/env ruby

require 'rubygems'
require 'ffi-rzmq'
require './message_handler.rb'

ip = "127.0.0.1"
port = "20174"

@@zmq_pub = MessageHandler::MessagePublisher.new
@@zmq_pub.create_publisher(ip, port)

@@action_msg = MessageHandler::ActionMessage.new

file = File.open("./config/ex_m3_device.csv")
content = file.read
upstream_id = "20141110"

msg = @@action_msg.create_startscan_msg(content, upstream_id)
@@zmq_pub.send_message(msg)
sleep(1)
@@zmq_pub.send_message(msg)

puts "csv file content: #{content}. msg #{msg}"
