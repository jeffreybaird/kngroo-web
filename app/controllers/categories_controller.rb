class CategoriesController < ApplicationController

  before_filter :authorize
  
  def index
    rsp = Foursquare::Venue.categories
    if rsp['meta']['code']==400
      @error = rsp['meta']['errorDetail']
    else
      for cat in rsp['response']['categories']
        puts cat['name']
        c = Category.find_or_create_by_title(cat['name'])
        c.icon = cat['icon']
        c.save
      end
    end
    @categories = Category.all
    respond_to do |format|
      format.json { render :json => @categories }
    end
  end
  
end
