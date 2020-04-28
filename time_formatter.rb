class TimeFormatter
  AVAILABLE_FORMAT = %w[year month day hour minute second].freeze

  FORMAT_TO_STRFTIME = {
    'year' => '%Y',
    'month' => '%m',
    'day' => '%d',
    'hour' => '%H',
    'minute' => '%M',
    'second' => '%S',
  }.freeze

  def initialize(format, time = Time.now)
    @received_formats = format.split(',')
    @time = time
  end

  def valid?
    return false if @received_formats.empty?

    @unknown_formats = @received_formats - AVAILABLE_FORMAT
    @unknown_formats.empty?
  end

  def time
    template = @received_formats.map { |i| FORMAT_TO_STRFTIME[i] }.join('-')
    "#{@time.strftime(template)}\n"
  end

  def errors
    return "Specify format!\n" if @received_formats.empty?

    "Unknown time format [#{@unknown_formats.join(', ')}]\n"
  end
end
