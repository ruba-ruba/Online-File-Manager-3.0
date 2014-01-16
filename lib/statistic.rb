class Statistic
  def self.daily_report
    DailyMailer.daily_uploads.deliver
  end
end