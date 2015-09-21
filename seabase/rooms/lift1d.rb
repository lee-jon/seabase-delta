room(:lift1d) do
  self.short_desc = "lift1d"
  self.desc = <<-DESC
    Top floor lift
  DESC

  self.accessible = false

  self.exit_down  = :lift1b
  self.exit_north = :tcorridor2

  item(:lift1d_buttons, 'button') do
    fixed = true
    self.presence = "Row of buttons"
    self.script_push = <<-SCRIPT
      puts "Which one... UP or DOWN"
    SCRIPT
  end

  self.script_enter = <<-SCRIPT
    if self.accessible != true
      puts "PING! OH BLOW! button keeps popping out!"
      puts "I need something to STICK it.."
      return false
    else
      puts "Lift goes up"
      return true
    end
  SCRIPT
end
