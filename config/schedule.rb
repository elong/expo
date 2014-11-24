job_type :ruby, "cd :path/lib/ && /usr/bin/ruby :task.rb" 
job_type :rake, "cd :path && /usr/bin/rake :task" 

every 10.minute do
  rake 'zhanhui:update_list', :output=>{:error=>':path/log/schedule.log'}
end

every 10.minute do
  rake 'zhanhui:update_city_code', :output=>{:error=>':path/log/schedule.log'}
end

# currently we don't wash list
# every 10.minute do
#   rake 'zhanhui:wash_list', :output=>{:error=>':path/log/schedule.log'}
# end

every 10.minute do
  rake 'zhanhui:update_details', :output=>{:error=>':path/log/schedule.log'}
end
