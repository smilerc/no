class HomeController < ApplicationController
  def index
    render json: { 
      message: "FluxPay Processing Platform API", 
      version: "1.0.0",
      status: "operational"
    }
  end
end