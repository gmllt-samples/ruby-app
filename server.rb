require 'webrick'
require_relative 'router'

def start_server
  port = ENV.fetch('PORT', '8080').to_i

  server = WEBrick::HTTPServer.new(
    Port: port,
    AccessLog: [],
    Logger: WEBrick::Log.new('/dev/null')
  )

  setup_routes(server)

  trap('INT') { server.shutdown }
  server.start
end
