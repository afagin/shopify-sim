class Image < Liquid::Drop
  def initialize(src, alt)
    @src = src
    @alt = alt
  end

  def to_s
    @src
  end

  def src
    @src
  end

  def alt
    @alt
  end
end