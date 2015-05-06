class VicesController < ApplicationController

  def new
    @vice = Vice.new
  end

  def all
    @vices = Vice.all
  end

  def destroy
    Vice.delete(params["id"])
    redirect_to action: "all"
  end

  def create
    name = params["vice"]["name"]
    url = params["vice"]["url"]
    category = params["Category"]["category"]
    Vice.create(name: name, url: url, category: category)
    redirect_to action: "all"
  end

end
