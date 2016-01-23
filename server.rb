require 'sinatra'
require 'liquid'
require 'json'
require 'sass'
require './standard_filters'

Liquid::Template.error_mode = :strict
Liquid::Template.register_filter StandardFilters
Liquid::Template.file_system = Class.new do
  def self.read_template_file(file, _)
    File.read "./skeleton-theme/snippets/#{file}.liquid"
  end
end

set :public_folder, './skeleton-theme/assets'

def parse_liquid_template(file)
  Liquid::Template.parse(File.read("./skeleton-theme/#{file}"))
end

get '/' do
  vars = YAML.load_file('index.yaml')
  html = parse_liquid_template('templates/product.liquid').render!(vars)
  layout = parse_liquid_template('layout/theme.liquid')
  layout.render! vars.merge('content_for_layout' => html)
end

get '*' do
  path = params['splat'].first
  if File.exist?(liquid_path = "./skeleton-theme/assets#{path}.liquid")
    content_type mime_type(File.extname(path))
    Liquid::Template.parse(File.read(liquid_path)).render!
  elsif File.exist?(liquid_path = "./skeleton-theme/assets#{path.sub(/\.css$/, '')}.liquid")
    content_type mime_type("css")
    Sass::Engine.new(Liquid::Template.parse(File.read(liquid_path)).render!(YAML.load_file('settings.yaml')), {syntax: :scss}).render
  else
    halt 404
  end
end