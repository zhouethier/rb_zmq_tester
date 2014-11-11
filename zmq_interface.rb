#!/usr/bin/env ruby

require 'rubygems'
require 'ffi-rzmq'
require './message_handler.rb'

require 'sinatra'
require 'haml'
require 'json'

configure do
  ip = "127.0.0.1"
  pub_port = "20174"
  
  puts "in configure"
  @@zmq_pub = MessageHandler::MessagePublisher.new
  @@zmq_pub.create_publisher(ip, pub_port)
  
  @@action_msg = MessageHandler::ActionMessage.new
end

get '/' do
  redirect '/start_scan'
end

get '/start_scan' do
  haml :scan, :format => :html5
end

post '/start_scan' do
  file = File.open("./config/ex_m3_device.csv")
  content = file.read
  upstream_id = "20141110"
    
  msg = @@action_msg.create_startscan_msg(content, upstream_id)
  @@zmq_pub.send_message(msg)

  # puts "csv file content: #{content}. msg #{msg}"
  puts "csv file content: #{content}"
end
