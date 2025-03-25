module Server
  class Response
    def self.build(status, body)
      [
        "HTTP/1.1 #{status}",
        "Content-Type: text/plain",
        "Content-Length: #{body.bytesize}",
        "Connection: close",
        "",
        body
      ].join("\r\n")
    end
  end
end
