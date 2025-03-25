require 'socket'
require 'logger'
require_relative 'request_handler'

module Server
  class HttpServer
    def initialize(port:)
      @port = port
      @server = TCPServer.new('0.0.0.0', port)
      puts "[INFO] Listening on port #{port}..."
    end

    def start
      loop do
        socket = @server.accept
        Thread.new do
          begin
            Server::RequestHandler.new(socket).handle
          rescue => e
            STDERR.puts "[ERROR] #{e.class}: #{e.message}"
            STDERR.puts e.backtrace.join("\n")
          end
        end
      end
    end
  end
end
