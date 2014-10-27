class MovesApi
  
  attr_reader :moves, :timeline
  
  def initialize(access_token, timeline)
    @moves    = Moves::Client.new(access_token)
    @timeline = timeline
  end
  
  def find_steps
    if timeline == 'day'
      steps = []
      daily_summary.each do |outer_hash|
        if outer_hash['summary'].present?
          outer_hash['summary'].each do |inner_hash|
            steps << inner_hash['steps']
          end
        end
      end
      stringify_array(steps)
    elsif timeline == 'week'
      steps = []
      weekly_summary.each do |outer_hash|
        if outer_hash['summary'].present?
          outer_hash['summary'].each do |inner_hash|
            if inner_hash['group'] == 'walking'
              steps << inner_hash['steps']
            end
          end
        end
      end
      stringify_array(steps)
    else
      steps = []
      monthly_summary.each do |outer_hash|
        if outer_hash['summary'].present?
          outer_hash['summary'].each do |inner_hash|
            if inner_hash['group'] == 'walking'
              steps << inner_hash['steps']
            end
          end
        end
      end
      stringify_array(steps)
    end
  end
  
  def find_times
    if timeline == 'day'
      dates = []
      daily_summary.each do |outer_hash|
        dates << outer_hash['date']
      end
    stringify_date(dates)
    elsif timeline == 'week'
      dates = []
      weekly_summary.each do |outer_hash|
        dates << outer_hash['date']
      end
    stringify_date(dates)
    else
      dates = []
      monthly_summary.each do |outer_hash|
        dates << outer_hash['date']
      end
    stringify_date(dates)
    end
  end
  
  def daily_summary
    moves.daily_summary
  end
  
  def weekly_summary
    moves.daily_summary(:from => first_of_week, :to => today)
  end
  
  def monthly_summary
    moves.daily_summary(:from => first_of_month, :to => today)
  end
  
  def today
    format = "%Y-%m-%d"
    Date.today.strftime(format)
  end
  
  def first_of_week
    format = "%Y-%m-%d"
    Date.today.at_beginning_of_week.strftime(format)
  end
  
  def first_of_month
    format = "%Y-%m-%d"
    Date.today.at_beginning_of_month.strftime(format)
  end
  
  def stringify_date(dates)
    format = "%m-%d-%Y"
    formatted_date = []
    dates.each do |date|
      formatted_date << Date.parse(date).strftime(format)
    end
    stringify_array(formatted_date)
  end
  
  def stringify_array(steps)
    steps.compact.join(",").gsub(',', '","')
  end
end