worker_processes 1
preload_app true
working_directory "/home/donbillete/Rails/lottery_game"
pid "tmp/pids/unicorn.pid"
stderr_path "log/unicorn.log"
stdout_path "log/unicorn.log"
listen "/tmp/unicorn.lottery_game.sock"

before_fork do |server, worker|
  # Disconnect since the database connection will not carry over
  defined? ActiveRecord::Base &&
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  # Start up the database connection again in the worker
  defined?(ActiveRecord::Base) &&
    ActiveRecord::Base.establish_connection
end