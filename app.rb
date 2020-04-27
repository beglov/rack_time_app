class App
  AVAILABLE_FORMAT = %w[year month day hour minute second].freeze

  FORMAT_TO_STRFTIME = {
    'year' => '%Y',
    'month' => '%m',
    'day' => '%d',
    'hour' => '%H',
    'minute' => '%M',
    'second' => '%S',
  }.freeze

  def call(env)
    @env = env

    [status, headers, body]
  end

  private

  def status
    return 404 unless time_path?
    return 400 if unknown_format?

    200
  end

  def headers
    {'Content-Type' => 'text/plain'}
  end

  def body
    return [] unless time_path?
    return ["Unknown time format [#{unknown_format.join(', ')}]\n"] if unknown_format?

    ["#{message}\n"]
  end

  def time_path?
    @env['PATH_INFO'] == '/time'
  end

  def unknown_format?
    !unknown_format.empty?
  end

  def unknown_format
    format_array - AVAILABLE_FORMAT
  end

  def format_array
    format.split(',')
  end

  def format
    params['format']
  end

  def params
    Rack::Utils.parse_nested_query(@env['QUERY_STRING'])
  end

  def message
    now = Time.now
    now.strftime(strftime_template)
  end

  def strftime_template
    format_array.map { |i| FORMAT_TO_STRFTIME[i] }.join('-')
  end
end
