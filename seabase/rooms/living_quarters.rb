room(:living_quarters) do
  self.desc = <<-DESC
    The Base takes on a more homely appearance as in the LIVING QUARTERS.
    Exits go NORTH, SOUTH, EAST and WEST
  DESC

  self.exit_north = :restroom
  self.exit_south = :tcorridor1
  self.exit_west  = :dental_surgery
  #self.exit_east

  item(:writing_bureau, 'bureau', 'writing') do
    self.presence = "Writing bureau"
    self.fixed    = true
    self.openable = true
    self.script_open = <<-SCRIPT
      puts "I see something..."
      get_root.move(:fountain_pen, :living_quarters, false)
    SCRIPT
  end
end
