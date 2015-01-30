require 'httparty'

SCHEDULER.every '1m', :first_in => 0 do |job|
  begin
    # Hit Xively JSON endpoint
    feedResult = HTTParty.get("https://api.xively.com/v2/feeds/1523709162",
                { :headers => { 'X-ApiKey' => "js5Sab5uZwmSsE2Ou1zWXRalPdXzrttAfaWmhtYA6FFjgBSt", "Content-Type" => 'application/json'}})

    # Get the current value
    current_value = feedResult['datastreams'][0]["current_value"]

    # Bind data to the DOM 
    send_event('xively_data', { current: current_value })
  end
end