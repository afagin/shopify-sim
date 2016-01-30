require './server'

if ENV['PUBLIC_DIR']
  map '/public' do
    run Rack::Directory.new(ENV['PUBLIC_DIR'])
  end
end

run Sinatra::Application