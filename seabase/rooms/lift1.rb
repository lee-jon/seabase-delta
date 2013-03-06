room(:lift1) do
  self.short_desc = "Lift no. 1"
  self.desc = <<-DESC
    
  DESC
  
  self.exit_north(:corridor4)
  
  item(:lift1_buttons, 'buttons') do
    fixed = true
    self.presence = "Row of buttons"
  end
end