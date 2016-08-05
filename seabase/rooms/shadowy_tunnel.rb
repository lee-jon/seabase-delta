room(:shadowy_tunnel) do
  self.short_desc = "shadowy_tunnel"
  self.desc = <<-DESC
    I'm at the end of a DARK SHADOWY TUNNEL. The way back is NORTH.
  DESC

  self.exit_north = :tcorridor1

  scenery(:sliding_doors, 'doors') do
    self.presence = "Huge metal sliding doors"
    self.desc = "Shut tight and HEAVY man"

    self.unlocked = false

    self.script_enter = <<-SCRIPT
      return false unless self.unlocked

      get_root.move(:player, :security_control)

      return false
    SCRIPT
  end
end
