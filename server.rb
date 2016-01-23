require 'sinatra'
require 'liquid'
require 'json'
require 'sass'
require './standard_filters'
require './file_system'

set :theme_path, 'skeleton-theme'
set :public_folder, "#{settings.theme_path}/assets"

before do
  Liquid::Template.error_mode = :strict
  Liquid::Template.register_filter StandardFilters
  Liquid::Template.file_system = FileSystem.new(settings.theme_path)
end

def parse_liquid_template(file)
  Liquid::Template.parse(File.read(file))
end

get '/' do
  vars = YAML.load_file('index.yaml')
  html = parse_liquid_template("#{settings.theme_path}/templates/product.liquid").render!(vars)
  layout = parse_liquid_template("#{settings.theme_path}/layout/theme.liquid")
  layout.render! vars.merge('content_for_layout' => html)
end

get '*' do
  if File.exist?(liquid_path = "#{settings.theme_path}/assets#{request.path}.liquid")
    content_type mime_type(File.extname(request.path))
    template = Liquid::Template.parse(File.read(liquid_path))
    template.render!(YAML.load_file('settings.yaml'))
  elsif File.exist?(liquid_path = "#{settings.theme_path}/assets#{request.path.sub(/\.css$/, '')}.liquid")
    content_type mime_type("css")
    template = Liquid::Template.parse(File.read(liquid_path))
    rendered = template.render!(YAML.load_file('settings.yaml'))
    Sass::Engine.new(rendered, {syntax: :scss}).render
  else
    halt 404
  end
end