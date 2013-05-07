room(:tcorridor3) do
  self.desc = <<-DESC
    The WALKWAY seems to get steeper here as it continues EAST & WEST. There's 
    a HUGE PASSAGE to the NORTH.
  DESC
  
  self.exit_west = :tcorridor2
  #self.exit_north = :huge_passage
  #self.exit_east = :tcorridor4
  
  item(:tv_camera, 'camera', 'tv') do
    self.presence = "TV Camera"
    self.desc = <<-DESC
      The LENS seems to be scanning along that CORRIDOR to the NORTH.
      I don't like the look of that.
    DESC

    self.covered = false
  end
  
  # self.script_north = <<-SCRIPT
end