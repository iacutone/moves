module UsersHelper
  
  def format_timeline(time)
    content_tag :h5 do
      time.titleize + ' Timeline'
    end
  end
end
