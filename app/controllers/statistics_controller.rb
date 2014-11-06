class StatisticsController < ApplicationController
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

  def displacement
    @statistics = Statistic.where(date: 2.weeks.ago..Date.today).order(:date).reverse_order
    positive_count = @statistics.pluck(:positive_count)
    negative_count = @statistics.pluck(:negative_count)
    render json: {
        labels: (0...14).map { |d| (Date.today - d).strftime('%m/%d') }.reverse,
        datasets: [
          {
            fillColor:        "rgba(255,204,204,0.3)",
            strokeColor:      "#ffcccc",
            pointColor:       "#ffcccc",
            pointStrokeColor: "#ffcccc",
            data: positive_count
          },
          {
            fillColor:        "rgba(204,204,255,0.3)",
            strokeColor:      "#ccccff",
            pointColor:       "#ccccff",
            pointStrokeColor: "#ccccff",
            data: negative_count
          }
        ]
      }
  end
end
