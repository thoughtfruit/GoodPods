class XmlValidationService

  def self.for url
    @url = url
    self
  end

  def self.valid?
    @validation = Nokogiri::XML(self.schema)
    if @validation.errors.any?
      return false
    else
      return true
    end
  end

  def self.schema
    HTTParty.get(@url).body
  end

end
