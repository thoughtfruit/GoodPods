class XmlValidator

  def initialize ; end

  def for url
    @url ||= url
    self
  end

  def validate
    @validation ||= Nokogiri::XML(schema)
    false if errors
    true unless errors
  end

  def schema
    HTTParty.get(@url).body
  end

  def errors
    @validation.errors
  end

end
