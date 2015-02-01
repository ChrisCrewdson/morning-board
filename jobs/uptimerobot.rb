require 'uptimerobot'

apiKey = ENV['UPTIMEROBOT_APIKEY']

SCHEDULER.every '1m', :first_in => 0 do |job|
  client = UptimeRobot::Client.new(apiKey: apiKey)

  monitors = client.getMonitors['monitors']['monitor']

  send_event('uptimerobot', {
    friendlyname0: monitors[0]['friendlyname'],
    status0: 'S' << monitors[0]['status'],
    friendlyname1: monitors[1]['friendlyname'],
    status1: 'S' << monitors[1]['status'],
    friendlyname2: monitors[2]['friendlyname'],
    status2: 'S' << monitors[2]['status'],
    friendlyname3: monitors[3]['friendlyname'],
    status3: 'S' << monitors[3]['status'],
  })
end
