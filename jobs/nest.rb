require 'nest_thermostat'

nest_user = ENV['NEST_USER']
nest_password = ENV['NEST_PASSWORD']

SCHEDULER.every '1m', :first_in => 0 do |job|
  nest = NestThermostat::Nest.new(
      email: nest_user,
      password: nest_password,
      temperature_scale: :celsius
    )
  first_nest = nest.status["shared"][nest.device_id]
  
  set_temp = nest.temperature;
  current_temp = nest.current_temp;
  humidity = nest.humidity;

  k_temp = current_temp + 273.15

  away = nest.away
  state = "off"
  leaf_src = ""

  if(first_nest['hvac_ac_state'])
    state = "cooling"
  elsif (first_nest['hvac_heater_state'])
    state = "heating"
  end
  
  if(nest.leaf)
    leaf_src = "assets/nest/nest_leaf.png"
  else
    leaf_src = "assets/nest/nest_leaf_trans.png"
  end

  send_event('nest', {
    set_temp: set_temp.round(1),
    current_temp: current_temp.round(1),
    k_temp: k_temp.round(1),
    state: state,
    away: away,
    leaf: leaf_src,
    humidity: humidity
  })
end
