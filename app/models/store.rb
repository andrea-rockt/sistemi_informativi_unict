include Math
class Store < ActiveRecord::Base
  acts_as_gmappable
  validates_uniqueness_of :name
  
  attr_accessor :current_user

  def gmaps4rails_address
      "#{self.address}, #{self.city}, #{self.country}"
  end
  
  def gmaps4rails_infowindow
      "<p><b>#{self.name}</b></p><p>#{self.gmaps4rails_address}</p>"
  end
  
  def gmaps4rails_sidebar
    classes = if !current_user.nil? && is_near?(format_address(current_user),self)
      "markers suggested"
    else
      "markers"
    end
    
    "<span class='#{classes}'>#{self.name}</span>"
        
  end
  
  protected
  def is_near?(address,store)

    geocoded_address=Gmaps4rails.geocode(address)
    
    lat = geocoded_address[0][:lat]
    long = geocoded_address[0][:lng]
    
    a = lat_long_to_x_y(store.lat,store.lng)
    b = lat_long_to_x_y(lat,long)
    
    distance= sqrt((a[0]-b[0])**2+(a[1]-b[1])**2)
    
    return distance<100000
  end
  
  def lat_long_to_x_y(lat,long)
    x = long*60*1852*Math.cos(lat)
    y = lat*60*1852
    
    return [x,y]
  end
  
  def format_address(current_user)
    "#{current_user.address},#{current_user.city},#{current_user.country}"
  end
end

