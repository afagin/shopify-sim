require './lib/server'
require 'rack-livereload'

if ENV['PUBLIC_DIR']
  map '/public' do
    run Rack::Directory.new(ENV['PUBLIC_DIR'])
  end
end

use Rack::LiveReload
run Sinatra::Application