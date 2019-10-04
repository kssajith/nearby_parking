module DateTimeHelper
  def sgt_to_utc(date_time_str)
    #Application time is in UTC by default
    Time.zone.parse(date_time_str) - 8.hours
  end

  def current_time_sgt
    Time.now.in_time_zone("Asia/Singapore")
  end
end
