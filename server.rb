require 'sinatra'
require 'liquid'
require 'json'
require 'erb'
require './liquid_ext'
require './string_ext'
require './shopify_filter'
require './shopify_file_system'

Liquid::Template.error_mode = :strict
Liquid::Template.register_filter ShopifyFilter
Liquid::Template.file_system = ShopifyFileSystem.new

def liquid_template(file)
  Liquid::Template.parse(File.read("theme/#{file}"))
end

def json
  JSON.parse(File.read('product.json')).tap do |hash|
    hash.default_proc = lambda do |_, key|
      unless File.exist?("theme/snippets/#{key}.liquid")
        raise "missing local #{key.inspect}"
      end
    end
  end
end

def render_in_layout(file)
  html = liquid_template(file).render!(json)
  layout = liquid_template('layout/theme.liquid')
  layout.render! json.merge('content_for_layout' => html)
end

set :public_folder, 'theme'

get '/product' do
  render_in_layout 'templates/product.liquid'
end

get '/cart' do
  render_in_layout 'templates/cart.liquid'
end

get '/checkout' do
  send_file 'checkout/checkout.html'
end