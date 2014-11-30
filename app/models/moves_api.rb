class MovesApi
  
  attr_reader :moves, :timeline
  
  def initialize(access_token, timeline)
    @moves    = Moves::Client.new(access_token)
    @timeline = timeline
  end
  
  def steps
  @hash = {}
    timeline.each do |outer_hash|
      if outer_hash['date'].present? && outer_hash['summary'].present?
        @hash[:date] = outer_hash['date']
        outer_hash['summary'].each do |inner_hash|
          @hash[:activity] = inner_hash['activity']
          @hash[:duration] = inner_hash['duration']
          @hash[:distance] = inner_hash['distance']
          @hash[:steps]    = inner_hash['setps']
          @hash[:calories] = inner_hash['calories']
        end
      end
    end
    @hash
  end
  
  def day
    moves.daily_summary
  end
  
  def week
    moves.daily_summary(:from => first_of_week, :to => today)
  end
  
  def month
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