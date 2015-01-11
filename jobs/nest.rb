require 'nest_thermostat'

nest_user = ENV['NEST_USER']
nest_password = ENV['NEST_PASSWORD']

use_metric_system = true

SCHEDULER.every '1m', :first_in => 0 do |job|
  nest = NestThermostat::Nest.new({email: nest_user,password: nest_password})
  first_nest = nest.status["shared"][nest.device_id]
  
  temp = nest.temperature;
  current_temp = nest.current_temp;
  humidity = nest.humidity;

  if (use_metric_system)
    temp = f_to_c(temp)
    current_temp = f_to_c(current_temp)
    k_temp = f_to_c(temp) + 273.15
  end
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
    temp: temp.round(1),
    state: state,
    away: away,
    leaf: leaf_src,
    current_temp: current_temp.round(1),
    humidity: humidity,
    k_temp: k_temp.round(1)
  })
end

# Converts fahrenheit to celcius.
def f_to_c(temp)
  return (((temp - 32) * 5) / 9)
end
