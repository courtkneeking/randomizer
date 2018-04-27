class HomeController < ApplicationController
  
  def index
    @places_list = places_list
    @fonts = fonts
    font_number = rand(0...fonts.length)
    @font = fonts[font_number] +" !important"
    color = "%06x" % (rand * 0xffffff)
    color_two = "%06x" % (rand * 0xffffff)
    @color = "#"+color
    @color_two = "#"+color_two
    if session[:zipcode] 
      render layout: "two.html"
    else
      render layout: "one.html"
    end
  end
  def zipcode
    session[:zipcode] = params[:zipcode]
    redirect_to "/"
  end
  def place
    zipcode = session[:zipcode]
    type = params[:type] 
    base = "https://maps.googleapis.com/maps/api/place/textsearch/json?"
    key = "&key=AIzaSyCCDOMuoRJs6evSFsAs0JXrWY4Mt3mZCYk"
    query = "&types=#{type}&query=#{zipcode}"
    url = base + key + query
    response = HTTP.get(url)
    parsed_response = JSON.parse(response.body)
    puts parsed_response
    length = parsed_response['results'].length
    number = rand(0..length)
    random = number
    session[:place] = parsed_response['results'][random]['name']
    session[:address] = parsed_response['results'][random]['formatted_address']
    session[:icon] = parsed_response['results'][random]['icon']
    session[:photos] = parsed_response['results'][random]['photos']
    redirect_to "/random"
  end
  def random
    @fonts = fonts
    font_number = rand(0...fonts.length)
    @font = fonts[font_number] +" !important"
    color = "%06x" % (rand * 0xffffff)
    color_two = "%06x" % (rand * 0xffffff)
    @color = "#"+color
    @color_two = "#"+color_two
    @url = session[:url]
    @place = session[:place]
    @address = session[:address]
    @icon = session[:icon]
  end
  def clear_session
    session[:zipcode] = nil
    redirect_to "/"
  end 
end



