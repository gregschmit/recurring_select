class SampleController < ApplicationController

  def index
  end

  def result
    render 'result', locals: { fake_model: params[:fake_model] }
  end
end
