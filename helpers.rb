module Helpers
  def yaml(path)
    YAML.load_file(path)
  end

  def yaml_merge(*paths)
    out = {}
    paths.each { |path| out.deep_merge!(yaml(path)) }
    out
  end

  def theme_path(path)
    File.join(settings.theme_path, path)
  end

  def scss(source)
    Sass::Engine.new(source, syntax: :scss).render
  end

  def parse_template(path)
    Liquid::Template.parse(File.read(path))
  end

  def render_template(vars, path)
    template = parse_template(theme_path(path))
    template.render!(vars, {strict_variables: true, strict_filters: true})
  end

  def render_template_in_theme(vars, path)
    html = render_template(vars, path)
    render_template(vars.merge('content_for_layout' => html), 'layout/theme.liquid')
  end
end
