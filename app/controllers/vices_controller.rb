class VicesController < ApplicationController

  def new
    @vice = Vice.new
    rt_key = "B63EA6sEEsGpRmazJhsQCR2QjmHd3LbBeeo4VX6l"
    rt_url = "https://www.rescuetime.com/anapi/data?key=#{rt_key}&format=json"
    results = HTTParty.get(rt_url)
    @options = results["rows"].map{|r| r[3]}.sort
    # populate a selection of sites from their api!!!!
  end

  def all
    @vices = Vice.all
    @total = 50
    # @remaining = 5
  end

  def destroy
    Vice.delete(params["id"])
    redirect_to action: "all"
  end

  def create
    name = params["Name"]["name"]
    category = params["Category"]["category"]
    # get the category by hitting their api!!!
    Vice.create(name: name, category: category)
    redirect_to action: "all"
  end

end
