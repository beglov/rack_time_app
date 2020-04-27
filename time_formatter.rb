class TimeFormatter
  FORMAT_TO_STRFTIME = {
    'year' => '%Y',
    'month' => '%m',
    'day' => '%d',
    'hour' => '%H',
    'minute' => '%M',
    'second' => '%S',
  }.freeze

  def initialize(time = Time.now)
    @time = time
  end

  def format(args)
    template = args.map { |i| FORMAT_TO_STRFTIME[i] }.join('-')
    @time.strftime(template)
  end
end
