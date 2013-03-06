room(:lift1) do
  self.short_desc = "Lift no. 1"
  self.desc = <<-DESC
    
  DESC
  
  self.exit_north = :corridor4
  self.exit_up    = :lift1b
  self.exit_down  = :lift1c
  
  item(:lift1_buttons, 'buttons') do
    fixed = true
    self.presence = "Row of buttons"
  end
end