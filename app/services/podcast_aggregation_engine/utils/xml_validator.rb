class XmlValidator

  def initialize ; end

  def for url
    @url ||= url
    self
  end

  def validate
    # ValidatorPackage::New(@url) # => true/false
  end

  def schema
    # XML returned
  end

end
