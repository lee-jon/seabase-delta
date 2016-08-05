room(:submarine) do
  self.short_desc = "submarine"
  self.desc = <<-DESC
    I've clambered into the MINI-SUB.
  DESC

  self.released = false

  self.script_exit do
    get_root.move(:player, :murky_depths)
  end

  scenery(:small_lever, 'lever') do
    self.presence = "Small lever"

    self.script_pull = <<-SCRIPT


      puts "HUMM...The engines start.."
      if parent.released
        puts "NO. I just can't be so cowardly. I have to stop that missile..."
      else
        puts 'Metalic-voice-"NO SECURITY RELEASE.'
        puts 'MINI-SUB LAUNCH ABORTED!"'
      end
    SCRIPT
  end
end
