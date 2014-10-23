#!/usr/bin/env ruby

require 'rubygems'
require 'ffi-rzmq'
require 'beefcake'

module MessageHandler
  class MessagePublisher
    def error_check(rc)
      if ZMQ::Util.resultcode_ok?(rc)
        false
      else
        STDERR.puts "Operation failed, errno [#{ZMQ::Util.errno}] description [#{ZMQ::Util.error_string}]"
        true
      end
    end

    def create_publisher (ip, port)
      @pub_context = ZMQ::Context.new(1)
      STDERR.puts "Failed to create context!" unless @pub_context
      
      @publisher = @pub_context.socket(ZMQ::PUB)
      STDERR.puts "Failed to create publisher!" unless @publisher
      
      pub_addr = "tcp://#{ip}:#{port}"
      rc = @publisher.connect(pub_addr)
      STDOUT.puts "created publisher, connected to #{pub_addr}" unless error_check(rc)
    end
    
    def send_message (msg)
      rc = @publisher.send_string "#{msg}"
      STDOUT.puts "sending data out: #{msg}" unless error_check(rc)
    end
  end
  
  class MessageSubscriber
    def error_check(rc)
      if ZMQ::Util.resultcode_ok?(rc)
        false
      else
        STDERR.puts "Operation failed, errno [#{ZMQ::Util.errno}] description [#{ZMQ::Util.error_string}]"
        true
      end
    end
    
    def create_subscriber(ip, port)
      @sub_context = ZMQ::Context.new(1)
      STDERR.puts "Failed to create context" unless @sub_context
      
      @subscriber = @sub_context.socket(ZMQ::SUB)
      STDERR.puts "Fail to create subscriber!" unless @subscriber
      
      sub_addr = "tcp://#{ip}:#{port}"
      rc = @subscriber.bind(sub_addr)
      # sub_addr = "tcp://#{ip}:#{port}"
      # rc = @subscriber.connect(sub_addr)
      @subscriber.setsockopt(ZMQ::SUBSCRIBE, '')
      STDOUT.puts "created subscriber, bind to :#{ip}:#{port}" unless error_check(rc)
    end
    
    def recv_message()
      message = ZMQ::Message.new
      rc = @subscriber.recv_string(message = '')
      STDOUT.puts "receiving datat in: #{message}" unless error_check(rc)
    end
  end

end    

      