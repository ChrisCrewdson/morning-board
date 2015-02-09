KEGBOT_APIKEY = ENV['KEGBOT_APIKEY']

SCHEDULER.every '5m', :first_in => 0 do |job|
  http = Net::HTTP.new("kegbot.chriscrewdson.com")

  # Hit Kegbot kegs endpoint
  response = http.request(Net::HTTP::Get.new("/api/v1/kegs"))
  raw_kegs = JSON.parse(response.body)  

  kegs = raw_kegs["objects"].map { |keg| 
    {
      name: keg["type"]["name"],
      progress: keg["percent_full"].round
    }
  }

  send_event('kegbot', { title: "Kegbot", progress_items: kegs } )
end