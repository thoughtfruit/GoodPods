class Status

  def self.find(slug)
    {
      "to-listen" => 'to-listen',
      "listened" => "listened",
      "listening" => "listening"
    }[slug]
  end
end
