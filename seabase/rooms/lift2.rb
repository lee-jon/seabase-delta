room(:lift2) do
  self.short_desc = "Lift 2"
  self.desc = <<-DESC
    Sea-Base Lift Number >2<. The EXIT is to the NORTH.
  DESC
  
  self.exit_north = :corridor2
  self.exit_up = :lift1b
  self.exit_down = :lift1c

  item(:floor_panel, 'panel') do
    self.desc = "It can be OPENED but It's LOCKED!"
    self.presence = "Floor panel"
  end

  item(:lift2_buttons, 'buttons') do
    fixed = true
    self.presence = "Row of buttons"    
  end
end