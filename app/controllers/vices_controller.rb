class VicesController < ApplicationController

  def new
    @vice = Vice.new
    # rt_key = ENV["rescue_time_api_key"] || ENV["api_key"]
    # rt_url = "https://www.rescuetime.com/anapi/data?key=#{rt_key}&format=json"
    # results = HTTParty.get(rt_url)
    # @options = results["rows"].map{|r| r[3]}.sort_by{|name| name.downcase}
    @options = ["Facebook",
                 "Gmail",
                 "localhost:3000",
                 "Pandora",
                 "swimminglongdistances.com",
                 "Github"].sort_by{|name| name.downcase}
    # populate a selection of sites from their api!!!!
  end

  def all
    @vices = Vice.all
  end

  def destroy
    Vice.delete(params["id"])
    redirect_to action: "all"
  end

  def create
    name = params["Name"]["name"] == "" ? nil : params["Name"]["name"]
    category = params["Category"]["category"] == "" ? nil : params["Category"]["category"]
    return redirect_to action: "new" unless name && category
    # get the category by hitting their api!!!
    Vice.create(name: name, category: category)
    redirect_to action: "all"
  end

end
