class HomeController < ApplicationController
  def index
    color = "%06x" % (rand * 0xffffff)
    color_two = "%06x" % (rand * 0xffffff)
    @color = "#"+color
    @color_two = "#"+color_two
  end
  def place
    lat = 34.180976034
    lng = -118.3071530
    radius = 500
    type = params[:type] 
    base = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?"
    key = "key=AIzaSyCCDOMuoRJs6evSFsAs0JXrWY4Mt3mZCYk"
    location = "&location=#{lat},#{lng}"
    radius = "&radius=#{radius}"
    type = "&types=#{type}"
    url = base + key + location + radius + type 
    session[:url] = url
    response = HTTP.get(url)
    parsed_response = JSON.parse(response.body)
    length = parsed_response['results'].length

    number = rand(0..length)
    random = number
    session[:place] = parsed_response['results'][random]['name']
    session[:address] = parsed_response['results'][random]['vicinity']

    redirect_to "/random"
  end
  def random
    @lat = session[:lat]
    color = "%06x" % (rand * 0xffffff)
    color_two = "%06x" % (rand * 0xffffff)
    @color = "#"+color
    @color_two = "#"+color_two
    @url = session[:url]
    @place = session[:place]
    @address = session[:address]
  end 

end
