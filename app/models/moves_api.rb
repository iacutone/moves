class MovesApi
  
  attr_reader :moves, :timeline
  
  def initialize(access_token, timeline)
    @moves    = Moves::Client.new(access_token)
    @timeline = timeline
  end
  
  def find_activity
    if timeline == 'day'
      steps = []
      dates = []
      daily_summary.each do |outer_hash|
        dates << date(outer_hash['date'])
        outer_hash['summary'].each do |inner_hash|
          steps << inner_hash['steps']
        end
      end
      stringify_array(steps)
    elsif timeline == 'week'
      steps = []
      weekly_summary.each do |outer_hash|
        outer_hash['summary'].each do |inner_hash|
          if inner_hash['group'] == 'walking'
            steps << inner_hash['steps']
          end
        end
      end
      stringify_array(steps)
    else
      steps = []
      monthly_summary.each do |outer_hash|
        outer_hash['summary'].each do |inner_hash|
          if inner_hash['group'] == 'walking'
            steps << inner_hash['steps']
          end
        end
      end
      stringify_array(steps)
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
  
  def date(date)
    Date.parse(date)
  end
  
  def stringify_array(steps)
    steps.join(",").gsub(',', '","')
  end
end