room(:fcorridor3) do
  self.desc = <<-DESC
    The corridor narrows here slightly at a junction between walkways.
    Exits are to the east, west & south. There's an awful smell of 
    rubbish coming from somewhere!
  DESC
  
  self.exit_east  = :fcorridor2
  self.exit_west  = :fcorridor4
  self.exit_south = :food_store
end