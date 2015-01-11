#require 'google_tasks'

client_id = ENV['TASKS_CLIENT_ID']
client_secret = ENV['TASKS_CLIENT_SECRET']
api_key = ENV['TASKS_API_KEY']

SCHEDULER.every '5m', :first_in => 0 do |job|
  # google_tasks = GoogleTasks.new(client_id, client_secret, api_key)

  # google_tasks.lists.items.map(&:title)
  # list_id = google_tasks.list.first.id
  # tasks = google_tasks.tasks(:list, list_id)

  # send_event('google_tasks', {
  #   tasks: tasks
  # })
end