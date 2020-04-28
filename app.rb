require_relative 'time_formatter'

class App
  def call(env)
    @env = env

    if time_path?
      handle_params
    else
      response(404, 'Not Found')
    end
  end

  private

  def time_path?
    @env['PATH_INFO'] == '/time'
  end

  def response(status, body)
    Rack::Response.new(
      body,
      status,
      {'Content-Type' => 'text/plain'}
    ).finish
  end

  def handle_params
    formatter = TimeFormatter.new(params['format'])

    if formatter.valid?
      response(200, formatter.time)
    else
      response(400, formatter.errors)
    end
  end

  def params
    Rack::Utils.parse_nested_query(@env['QUERY_STRING'])
  end
end
