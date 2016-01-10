class String
  def to_handle
    self.downcase.gsub(/\W/, ' ').gsub(/\ +/, '-').gsub(/(-+)$/, '').gsub(/^(-+)/, '')
  end
end
