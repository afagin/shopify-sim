require 'sinatra'
require 'liquid'
require 'json'
require 'sass'
require './standard_filters'
require './file_system'
require './image'
require 'awesome_print'

set :theme_path, ENV['THEME_PATH'] || 'skeleton-theme'

def parse_template(path)
  Liquid::Template.parse(File.read(path))
end

def yaml(path)
  YAML.load_file(path)
end

before do
  Liquid::Template.error_mode = :strict
  Liquid::Template.register_filter StandardFilters
  Liquid::Template.file_system = FileSystem.new(settings.theme_path)
end

post '/cart/add' do
  params.awesome_inspect(html: true)
end

get '/' do
  vars = yaml('index.yaml')
  template = Liquid::Template.parse(File.read("#{settings.theme_path}/templates/product.liquid"))
  html = template.render!(vars, {strict_variables: true, strict_filters: true})

  layout_template = Liquid::Template.parse(File.read("#{settings.theme_path}/layout/theme.liquid"))
  layout_template.render!(vars.merge('content_for_layout' => html), {strict_variables: true, strict_filters: true})
end

get '/assets/*' do
  if File.exist?(path = "#{settings.theme_path}#{request.path}.liquid")
    content_type mime_type(File.extname(request.path))
    return parse_template(path).render!(yaml('settings.yaml'))
  end

  if File.exist?(path = "#{settings.theme_path}#{request.path.sub(/\.css$/, '')}.liquid")
    content_type mime_type("css")
    rendered = parse_template(path).render!(yaml('settings.yaml'))
    return Sass::Engine.new(rendered, syntax: :scss).render
  end

  if File.exist?(path = "#{settings.theme_path}#{request.path}")
    send_file path
  end

  halt 404
end