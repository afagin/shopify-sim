class Image
  def initialize(url, alt)
    @url = url
    @alt = alt
  end

  def to_liquid
    @url
  end

  def alt
    @alt
  end
end