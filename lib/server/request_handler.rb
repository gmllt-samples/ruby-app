require 'uri'
require 'time'
require_relative 'response'
require_relative '../utils/parser'
require_relative '../utils/logger'

module Server
  class RequestHandler
    def initialize(socket)
      @socket = socket
    end

    def handle
      start_time = Time.now
      request_line = @socket.gets
      return unless request_line

      method, full_path, _ = request_line.split
      path, query = full_path.split('?', 2)
      params = URI.decode_www_form(query || '').to_h

      wait   = Utils::Parser.pick(Utils::Parser.parse(params['wait']))
      status = Utils::Parser.pick(Utils::Parser.parse(params['status'])) || 200
      size   = Utils::Parser.pick(Utils::Parser.parse(params['response_size'])) || 20

      sleep(wait) if wait

      body = 'X' * size.to_i
      response = Server::Response.build(status, body)
      @socket.write(response)
      @socket.close

      duration = Time.now - start_time
      Utils::Logger.log(method, path, params, status, body.bytesize, duration)
    end
  end
end
