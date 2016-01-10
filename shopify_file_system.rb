class ShopifyFileSystem
  def read_template_file(file, _)
    File.read "theme/snippets/#{file}.liquid"
  end
end
