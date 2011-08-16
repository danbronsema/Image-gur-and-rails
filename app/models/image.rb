class Image < ActiveRecord::Base
  
  before_save :check_url  
  
  include HTTParty
  format :plain
  base_uri 'http://api.imgur.com/2'

  def self.post_image(url)
    @key = "b1b3ecc74ad44245a9dd7dfe120d53b5"  
    response = self.post("/upload.json", 
      {:query => 
          {:key => @key, :image => url}
      })  
    image = JSON.parse(response.body)
    image["upload"]["links"]["original"]
  end
  
  def check_url
    if self.image_url.nil?
      self.errors.add("no image Url")
    end
  end
          
end
