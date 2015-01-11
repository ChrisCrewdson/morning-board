require 'tesla-api'

username = ENV['TESLA_USERNAME']
password = ENV['TESLA_PASSWORD']

SCHEDULER.every '5m', :first_in => 0 do |job|
  tesla = TeslaAPI::Connection.new(username, password)
  mycar = tesla.vehicle
  charge_state = mycar.charge_state

  send_event('tesla', {
    battery_percentage: charge_state.battery_percentage
  })
end