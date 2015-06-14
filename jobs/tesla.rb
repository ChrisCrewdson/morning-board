require 'tesla_api'

username = ENV['TESLA_USERNAME']
password = ENV['TESLA_PASSWORD']

SCHEDULER.every '5m', :first_in => 0 do |job|
  tesla = TeslaApi::Client.new(username, password)
  mycar = tesla.tesla_api
  charge_state = mycar.charge_state

  send_event('tesla', {
    battery_percentage: charge_state["battery_level"],
    battery_range_miles: charge_state["battery_range"].round(0),
    hours_to_full_charge: charge_state["time_to_full_charge"],
    state: charge_state["charging_state"] == "Charging" ? "charging" : "idle"
  })
end
