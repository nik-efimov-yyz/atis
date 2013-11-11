source_file = File.open(Rails.root.join("db","data", "airports.txt"))

Airport.delete_all

source_file.each do |line|
  next unless line.match(/^A/)
  data = line.split(",")
  icao, name, lat, lon, elevation = data[1..5]

  Airport.create! icao: icao, name: name, lat: lat, lon: lon, elevation: elevation

end