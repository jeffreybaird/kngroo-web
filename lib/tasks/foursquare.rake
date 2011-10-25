require 'foursquare'

# Foursquare::Venue.client_id = ENV['FOURSQUARE_CLIENT_ID']
# Foursquare::Venue.client_secret = ENV['FOURSQUARE_CLIENT_SECRET']

task :import_categories => :environment do

  cats = Foursquare::Venue.categories
  puts "found categories"
  for cat in cats['response']['categories']
    puts cat['name']
    c = Category.find_or_create_by_title(cat['name'])
  end
  
end

task :import_venues => :environment do

  # will eventually expand to nationwide  

  # lats = (15..45).map {|e| e}
  # lngs = (-120..-75).map {|e| e}
  
  # for lat in 0.step(lats.count, 5).map {|e| lats[e]}
  #   for lng in 0.step(lngs.count, 5).map {|e| lngs[e]}
  #     Foursquare::Venue.search(ll:"#{lat},#{lng}",range:"")
  #   end
  # end

  # for now, focus on Tampa Bay
  cats = Foursquare::Venue.categories
  for cat in cats['response']['categories']
    response = Foursquare::Venue.search(ll:"27.7657260197085,-82.63374998029151",radius:100000,intent:"browse",categoryId:cat['id'])
    groups = response['response']['groups']
    if groups && !groups.empty?
      items = response['response']['groups'][0]['items']
      for item in items
        venue = Venue.find_or_create_by_name(item['name'])
        venue.address = item['location']['address']
        venue.lat = item['location']['lat']
        venue.lng = item['location']['lng']
        venue.save
      end
    end
    puts "loaded #{items.count} venues for category #{cat['name']}"
  end
  
end
