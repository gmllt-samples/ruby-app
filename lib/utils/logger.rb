require 'json'
require 'time'

module Utils
  class Logger
    def self.log(method, path, params, status, size, duration)
      puts({
             timestamp: Time.now.iso8601,
             method: method,
             path: path,
             params: params,
             status: status,
             response_size: size,
             duration: duration.round(4)
           }.to_json)
    end
  end
end
