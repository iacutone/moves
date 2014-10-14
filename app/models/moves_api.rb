class MovesApi
  
  attr_reader :moves
  
  def moves(access_token)
    @moves = Moves::Client.new(access_token)
  end
  
  def daily_summary
    super
    binding.pry
    moves.daily_summary.first
  end
  
  def walking_activity
    daily_summary['summary'].last['steps']
  end
end