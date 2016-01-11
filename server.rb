require 'sinatra'
require 'liquid'
require 'json'
require './liquid_ext'
require './string_ext'
require './shopify_filter'
require './shopify_file_system'

Liquid::Template.error_mode = :strict
Liquid::Template.register_filter ShopifyFilter
Liquid::Template.file_system = ShopifyFileSystem.new

set :public_folder, '../skeleton-theme/assets'

def liquid_template(file)
  Liquid::Template.parse(File.read("../skeleton-theme/#{file}"))
end

get '/' do
  json = {"product" => JSON.parse(File.read('product.json'))}
  html = liquid_template('templates/product.liquid').render!(json)
  layout = liquid_template('layout/theme.liquid')
  layout.render! json.merge('content_for_layout' => html)
end

get '*' do
  path = params['splat'].first
  liquid_path = "../skeleton-theme/assets#{path}.liquid"
  if File.exist?(liquid_path)
    content_type mime_type(File.extname(path))
    Liquid::Template.parse(File.read(liquid_path)).render!
  else
    halt 404
  end
end