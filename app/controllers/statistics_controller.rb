class StatisticsController < ApplicationController
  def index
    @statistics = Statistic.all
    respond_to do |format|
      format.html
      format.json{ render json: @statistics }
    end
  end
end