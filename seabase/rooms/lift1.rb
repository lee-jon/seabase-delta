room(:lift1) do
  self.short_desc = "Lift no. 1"
  self.desc = <<-DESC
    Sea-base lift Number >2<.
    The exit is to the north.
  DESC
  
  self.exit_north = :corridor4
  self.exit_up    = :lift1b
  self.exit_down  = :lift1c

    
  self.script_enter = <<-SCRIPT
    puts "A light comes on"
    return true
  SCRIPT
  
  item(:lift1_buttons, 'button') do
    fixed = true
    self.presence = "Row of buttons"
    self.script_push = <<-SCRIPT
      puts "Which one... UP or DOWN"
    SCRIPT
  end
end