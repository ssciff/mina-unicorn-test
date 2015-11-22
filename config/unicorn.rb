worker_processes 16
listen "127.0.0.1:3000"

preload_app true
GC.respond_to?(:copy_on_write_friendly=) and GC.copy_on_write_friendly = true

shared_dir = File.expand_path('../../../shared/', __FILE__)
pid "#{shared_dir}/pids/unicorn.pid"

before_fork do |server, worker|
	  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
	  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end
