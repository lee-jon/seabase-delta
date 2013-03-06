room(:station_echo) do
  self.short_desc = "Station Echo."
  self.desc = <<-DESC
    I am on a platform at STATION ECHO. There is a compartment to the NORTH.
  DESC
  
  self.exit_north = :missile_room
  self.destination = :station_foxtrot
end