room(:lift1d) do
  self.short_desc = "lift1d"
  self.desc = <<-DESC
    Top floor lift
  DESC

  self.exit_down = :lift1b

  self.script_enter = <<-SCRIPT
    puts "PING! OH BLOW! button keeps popping out!
    puts "I need something to STICK it.."
    return false
  SCRIPT
end
