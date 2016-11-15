room(:warhead_platform) do
  self.short_desc = "platform"
  self.desc = <<-DESC
    I am now high up on the WARHEAD PLATFORM.
    A small ladder leads UP & the LAUNCH PAD
    is quite a long JUMP below.
  DESC

  self.exit_up   = :warhead
  self.exit_down = :launch_pad

  self.script_jump = :launch_pad

  # Items
  scenery(:beam_of_light, "beam") do
    self.presence = "Thin beam of light"
    self.desc = "On reflection, I'd rather not.."

    self.script_reflect = <<-SCRIPT
      puts "THE BEAM IS REFLECTED BACK BY THE FOIL AND GOES OUT!!"
      get_root.move(:beam_of_light, :void)
      get_root.find(:nuclear_missile).active = false
    SCRIPT
  end
end
