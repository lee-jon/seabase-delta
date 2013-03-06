room(:lift1) do
  self.short_desc = "Lift no. 1"
  self.desc = <<-DESC
    
  DESC
  
  self.exit_north = :corridor4
  self.exit_up    = :lift1b
  self.exit_down  = :lift1c
  
  item(:lift1_buttons, 'button') do
    fixed = true
    self.presence = "Row of buttons"
    self.script_push = <<-SCRIPT
      puts "Which one... UP or DOWN"
    SCRIPT
    
    #    TODO: on enter light comes on
  end
end