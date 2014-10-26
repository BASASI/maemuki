rails_root = `pwd`.chomp

worker_processes Integer(ENV['WEB_CONCURRENCY'] || 3)

timeout 15
preload_app true

listen File.expand_path('tmp/maemuki.sock', rails_root)
pid File.expand_path('tmp/maemuki.pid', rails_root)

stderr_path File.expand_path('log/unicorn.log', rails_root)
stdout_path File.expand_path('log/unicorn.log', rails_root)

before_fork do |server, worker|
  old_pid = "#{server.config[:pid]}.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill('QUIT', File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end

  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end
