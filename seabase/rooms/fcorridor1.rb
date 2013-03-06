room(:fcorridor1) do
  self.desc = <<-DESC
    This is the second lever corridor system going east & west. The lift
    entrance is south and a walkway also leads north.
  DESC
  
  self.exit_south = :lift1b
  self.exit_north = :bottle_store
  self.exit_east  = :fcorridor2
  self.exit_west  = :fcorridor4
end