class Image < Liquid::Drop
  def initialize(url, alt)
    @url = url
    @alt = alt
  end

  def to_s
    @url
  end

  def alt
    @alt
  end
end