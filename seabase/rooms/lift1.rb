room(:lift1) do
  self.short_desc = "Lift no. 1"
  self.desc = <<-DESC
    Sea-base lift Number >1<.
    The exit is to the north.
  DESC
  
  self.exit_north = :corridor4
  self.exit_up    = :lift1b
  self.exit_down  = :lift1c

  self.script_enter = <<-SCRIPT
    puts "A light comes on<br>"
    return true
  SCRIPT
  
  item(:lift1_buttons, 'button') do
    fixed = true
    self.presence = "Row of buttons"
    self.script_push = <<-SCRIPT
      puts "Which one... UP or DOWN"
    SCRIPT
  end
  
  self.script_up  = <<-SCRIPT
    puts "Shhh doors close. Lift ascends."
    puts "Doors open."
  SCRIPT
  
  self.script_down = <<-SCRIPT
    puts "Bottom floor!"
    return false
  SCRIPT
end