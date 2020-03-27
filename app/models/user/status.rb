class User::Status

  def self.find(slug)
    {
      "to-listen" => 'to-listen',
      "listening" => "listening",
      "listened" => "listened"
    }[slug]
  end
end
