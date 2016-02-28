require 'sinatra'
require 'liquid'
require 'json'
require 'sass'
require 'awesome_print'
require 'active_support'
require_relative './standard_filters'
require_relative './file_system'
require_relative './image'
require_relative './helpers'

set :theme_path, ENV['THEME_PATH'] || 'skeleton-theme'

helpers Helpers

before do
  Liquid::Template.error_mode = :strict
  Liquid::Template.register_filter StandardFilters
  Liquid::Template.file_system = FileSystem.new(settings.theme_path)
end

get '/' do
  vars = yaml_merge('yaml/index.yaml', 'yaml/settings.yaml', 'yaml/collections.yaml')
  render_template_in_theme(vars, 'templates/index.liquid')
end

get '/calendar' do
  vars = yaml_merge('yaml/index.yaml', 'yaml/calendar.yaml', 'yaml/settings.yaml', 'yaml/collections.yaml')
  render_template_in_theme(vars, 'templates/product.liquid')
end

get '/mug' do
  vars = yaml_merge('yaml/index.yaml', 'yaml/mug.yaml', 'yaml/settings.yaml', 'yaml/collections.yaml')
  render_template_in_theme(vars, 'templates/product.liquid')
end

post '/cart/add' do
  content_type 'text'
  params.inspect
end

get '/files/*' do
  redirect 'http://lorempixel.com/800/150'
end

get '/assets/*' do
  raise 'Invalid path' if request.path.include?('..')

  if File.exist?(path = theme_path("#{request.path}.liquid"))
    content_type mime_type(File.extname(request.path))
    return parse_template(path).render!(yaml('yaml/settings.yaml'))
  end

  if File.exist?(path = theme_path("#{request.path.sub(/\.css$/, '')}.liquid"))
    content_type mime_type('css')
    return scss(parse_template(path).render!(yaml('yaml/settings.yaml')))
  end

  if File.exist?(path = theme_path(request.path))
    send_file path
  end

  halt 404
end