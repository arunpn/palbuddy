task :server_start do
  port = '5000'
  puts 'Starting Unicorn App Server - Development Env'
  # execute unicorn command specifically in development
  # port at 3000 if unspecified
  sh "cd #{Rails.root} && RAILS_ENV=development unicorn_rails -p #{port} -c config/unicorn.rb -D"
end
# an alias task
task :sstart => :server_start