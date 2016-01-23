require 'rack/test'
require 'rspec'
require 'rspec-html-matchers'

ENV['RACK_ENV'] = 'test'

require_relative '../server'

module RSpecMixin
  include Rack::Test::Methods
  def app() Sinatra::Application end
end

RSpec.configure do |config|
  config.include RSpecMixin
  config.include RSpecHtmlMatchers
end