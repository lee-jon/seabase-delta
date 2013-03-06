room(:lift2) do
  self.exit_north = :corridor2
  self.exit_up = :lift1b
  self.exit_down = :lift1c
  self.desc = <<-DESC
    Sea-Base Lift Number >2<. The EXIT is to the NORTH.
  DESC
  self.short_desc = "Lift 2"
  item(:floor_panel, 'panel') do
    self.desc = "It can be OPENED but It's LOCKED!"
    self.presence = "Floor panel"
  end
  item(:lift2_buttons, 'buttons') do
    self.presence = "Row of buttons"
  end
end