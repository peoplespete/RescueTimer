class DashboardController < ApplicationController

  def index
    @vices = Vice.all
  end

  def new
    binding.pry
    # params
    # @vices = [Vice.create(category: "glancer", name: "Facebook", url: "www.facebook.com")]
  end


end
