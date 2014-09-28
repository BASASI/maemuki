class StatisticsController < ApplicationController
  def index
    @statistics = Statistic.all
    respond_to do |format|
      format.html
      format.json{ render json: @statistics }
    end
  end

  def stats
    query = {}
    if params[:range] == "3days"
      query = {date: 3.days.ago..Date.today}
    elsif params[:range] == "1week"
      query = {date: 1.week.ago..Date.today}
    elsif params[:range] == "2weeks"
      query = {date: 2.weeks.ago..Date.today}
    end
    @statistics = Statistic.where(query)
    positive_count = @statistics.pluck(:positive_count).inject { |sum, c| sum += c}
    negative_count = @statistics.pluck(:negative_count).inject { |sum, c| sum += c}
    render json: [
        {value: positive_count, color: '#ffcccc', label: "ポジ"},
        {value: negative_count, color: '#ccccff', label: "ネガ"}
      ]
  end
end