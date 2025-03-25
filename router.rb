require_relative 'handlers/root'

def setup_routes(server)
  server.mount_proc '/' do |req, res|
    handle_root(req, res)
  end
end
