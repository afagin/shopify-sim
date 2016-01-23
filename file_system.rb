class FileSystem
  def initialize(root)
    @root = root
  end

  def read_template_file(file, _)
    File.read(File.join(@root, "snippets", "#{file}.liquid"))
  end
end
