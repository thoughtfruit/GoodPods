class NullClientId
end

$CLIENT_ID = ENV['CLIENT_ID'] || NullClientId
puts $CLIENT_ID
