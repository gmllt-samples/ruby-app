require 'json'
require 'time'
require_relative '../lib/param_parser'
require_relative '../lib/logger'

def handle_root(req, res)
  start_time = Time.now.utc
  params = req.query

  wait = ParamParser.parse(params['wait'], :float, default: 0.0)
  status = ParamParser.parse(params['status'], :int, default: 200)
  size = ParamParser.parse(params['response_size'], :int, default: 100)

  sleep(wait) if wait > 0

  payload = 'X' * size

  res.status = status
  res['Content-Type'] = 'application/json'
  res.body = JSON.generate({
                             status: status,
                             wait: wait,
                             response_size: size,
                             payload: payload
                           })

  log_json({
             timestamp: start_time.iso8601,
             ip: req.remote_ip,
             method: req.request_method,
             path: req.path,
             params: params,
             status: status,
             wait: wait,
             response_size: size
           })
end
