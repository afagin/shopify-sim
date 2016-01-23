require 'sinatra'
require 'liquid'
require 'json'
require 'sass'
require './liquid_ext'
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
  vars = YAML.load_file('index.yaml')
  html = liquid_template('templates/product.liquid').render!(vars)
  layout = liquid_template('layout/theme.liquid')
  layout.render! vars.merge('content_for_layout' => html)
end

get '*' do
  path = params['splat'].first
  if File.exist?(liquid_path = "../skeleton-theme/assets#{path}.liquid")
    content_type mime_type(File.extname(path))
    Liquid::Template.parse(File.read(liquid_path)).render!
  elsif File.exist?(liquid_path = "../skeleton-theme/assets#{path.sub(/\.css$/, '')}.liquid")
    content_type mime_type("css")
    Sass::Engine.new(Liquid::Template.parse(File.read(liquid_path)).render!({
                                                                                'settings' => {'base_font_size' => '12px',
                                                                                               'background_color' => 'white',
                                                                                               'text_color' => 'black',
                                                                                               'link_color' => 'blue',
                                                                                               'base_font_family' => 'Arial'
                                                                                }
                                                                            }), {syntax: :scss}).render
  else
    halt 404
  end
end