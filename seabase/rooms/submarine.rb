room(:submarine) do
  self.short_desc = "submarine"
  self.desc = <<-DESC
    I've clambered into the MINI-SUB.
  DESC

  self.released = false

  self.script_exit = <<-SCRIPT
    get_root.move(:player, :murky_depths)
  SCRIPT

  scenery(:small_lever, 'lever') do
    self.presence = "Small lever"

    self.script_pull = <<-SCRIPT
      puts "HUMM...The engines start.."

      if parent.released
        if get_root.find(:nuclear_missile).active
          puts "NO. I just can't be so cowardly. I have to stop that missile..."
        else
          puts "WELL DONE ED!!!"
          puts "WHAT A STORY THIS IS GOING TO MAKE!"
          puts "\n"
          sleep 5
          puts "END OF GAME"
          get_root.move(:player, void)
          sleep 10
          puts "Try again?"
          exit
        end
      else
        puts 'Metalic-voice-"NO SECURITY RELEASE.'
        puts 'MINI-SUB LAUNCH ABORTED!"'
      end
    SCRIPT
  end
end
