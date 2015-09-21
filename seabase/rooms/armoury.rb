room(:armoury) do
  self.short_desc = "armoury"
  self.desc = <<-DESC
    The SEA-BASE ARMOURY. The exit is SOUTH
  DESC

  self.exit_south = :tcorridor2

  item(:spear_gun, 'speargun') do
    self.presence = "Speargun (loaded)"
    self.loaded = true

    self.script_fire = <<-SCRIPT
      if get_room.find(:octopus) && self.loaded
        puts "SSHHHH! Spear hits in the eye!"
        puts "And it gets really annoyed"

        self.loaded = false

        self.presence = "Empty speargun"
        self.short_desc = "Empty speargun"

        get_root.move(:ink, :murky_depths)
      else
        if self.loaded
          puts "Not just yet Ed!"
        else
          puts "I can't do that Ed."
        end

        return false
      end
    SCRIPT
  end
end
