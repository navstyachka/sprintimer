class TimerController < ApplicationController

  def index

  end

  def create
    data = params[:data]
    @timer = Timer.create data: data

    if @timer.errors.size>0
      render status: 422, template: "timer/create_error"
    else
      render status: 201
    end

  end

end
