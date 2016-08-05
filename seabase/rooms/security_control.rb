room(:security_control) do
  self.short_desc = "security_control"
  self.desc = <<-DESC
    This is SEABASE SECURITY CONTROL. The way out is NORTH.
  DESC

  self.exit_north = :shadowy_tunnel

  scenery(:knob, 'knob') do
    self.presence = "Knob"
    self.desc = "Mini-Sub Release"

    self.script_pull = <<-SCRIPT
      get_root.find(:submarine).released = true
      puts "OK"
    SCRIPT
  end
end
