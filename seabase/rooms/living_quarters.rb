room(:living_quarters) do
  self.desc = <<-DESC
    The Base takes on a more homely appearance as in the LIVING QUARTERS.
    Exits go NORTH, SOUTH, EAST and WEST
  DESC
  
  self.exit_north = :restroom
  self.exit_south = :tcorridor1
  
  # Logic
  
  item(:writing_bureau, 'writing', 'bureau') do
    self.presence = "Writing bureau"
    self.fixed    = true
    self.openable = true
  end
end