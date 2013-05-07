room(:shower_room) do
  self.desc = <<-DESC
    I am in the SHOWER-ROOM. The exits are NORTH and SOUTH.
  DESC
  
  self.exit_north = :library
  self.exit_south = :restroom
  
  scenery(:tap, 'tap') do
    self.presence = 'Tap'
    self.short_desc = 'Tap'
  end
end