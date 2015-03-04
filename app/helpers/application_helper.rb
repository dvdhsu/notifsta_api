module ApplicationHelper
  def title(value)
    unless value.nil?
      @title = "#{value} | NotifstaWebapp"
    end
  end
end
