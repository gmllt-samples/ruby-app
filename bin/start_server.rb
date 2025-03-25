#!/usr/bin/env ruby
require_relative '../config/environment'

server = Server::HttpServer.new(port: ENV.fetch('PORT', 8080).to_i)
server.start

