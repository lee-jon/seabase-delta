room(:lift1b) do
  self.short_desc = "Lift no. 1"
  self.desc = <<-DESC
    Sea-base lift Number >1<.
    The exit is to the north.
  DESC

  self.exit_down  = :lift1
  self.exit_up    = :lift1d
  self.exit_north = :fcorridor1

  item(:lift1b_buttons, 'button') do
    fixed = true
    self.presence = "Row of buttons"
    self.script_push = <<-SCRIPT
      puts "Which one... UP or DOWN"
    SCRIPT
  end
end
