require 'json'

class FacesFetcher
  @@defaultPhotoURL =  "https://pivots.pivotallabs.com/assets/default_directory_profile_photo.png"
  @@localDefaultImage = "/assets/default_directory_profile_photo.png"

  def initialize(pivots_url)
    @pivots ||= JSON.parse(Net::HTTP.get(URI(pivots_url)))
  end

  def new_pivots(location)
    @new_pivots = all_pivots_by_location(location).sort do |p1, p2|
      p2['started_on'] <=> p1['started_on']
    end[0..9].map do |pivot|
      {
          first_name: pivot['first_name'],
          last_name: pivot['last_name'],
          photo_url: if pivot['photo_url'] == @@defaultPhotoURL then @@localDefaultImage else pivot['photo_url'] end,
          title: pivot['title']
      }
    end
  end

  def all_pivots(location)
    @all_pivots = all_pivots_by_location(location).map do |pivot|
      {
          first_name: pivot['first_name'],
          last_name: pivot['last_name'],
          photo_url: if pivot['photo_url'] == @@defaultPhotoURL then @@localDefaultImage else pivot['photo_url'] end,
          title: pivot['title']
      }
    end
  end

  def all_pivots_by_location(location)
    @all_pivots_by_location = @pivots.select do |pivot|
      pivot['location_name'] == location
    end
  end
end

