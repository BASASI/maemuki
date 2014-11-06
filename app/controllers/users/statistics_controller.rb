class Users::StatisticsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:stats, :displacement]

  def stats
    query = {}
    if params[:range] == "3days"
      query = {date: 3.days.ago..Date.today}
    elsif params[:range] == "1week"
      query = {date: 1.week.ago..Date.today}
    elsif params[:range] == "2weeks"
      query = {date: 2.weeks.ago..Date.today}
    end
    @statistics = @uesr.where(query)
    positive_count = @statistics.pluck(:positive_count).inject { |sum, c| sum += c}
    negative_count = @statistics.pluck(:negative_count).inject { |sum, c| sum += c}
    render json: [
        {value: positive_count, color: '#ee7835', label: "ポジ"},
        {value: negative_count, color: '#94c9d0', label: "ネガ"}
      ]
  end

  def displacement
    @statistics = @user.where(date: 2.weeks.ago..Date.today).order(:date).reverse_order
    positive_count = @statistics.pluck(:positive_count)
    negative_count = @statistics.pluck(:negative_count)
    render json: {
        labels: (0...14).map { |d| (Date.today - d).strftime('%m/%d') }.reverse,
        datasets: [
          {
            fillColor:        "rgba(238,120,53,0.3)",
            strokeColor:      "#ee7835",
            pointColor:       "#ee7835",
            pointStrokeColor: "#ee7835",
            data: positive_count
          },
          {
            fillColor:        "rgba(148,201,208,0.3)",
            strokeColor:      "#94c9d0",
            pointColor:       "#94c9d0",
            pointStrokeColor: "#94c9d0",
            data: negative_count
          }
        ]
      }
  end

  private

    def set_user
      @user = User.find(params[:user_id])
    end
end
