room(:carriage) do
  self.desc = <<-DESC
    I'm in the Travel-Tube car. A metallic voice from the
    loudspeaker-"CLUNK-CLICK OR YOU'RE SURE TO BE SICK"
  DESC
  
  self.short_desc = <<-DESC
    A metallic voice from the loudspeaker-"CLUNK-CLICK OR YOU'RE
    SURE TO BE SICK"
  DESC

  self.script_exit = <<-SCRIPT
    if get_room.open
      current_station = get_root.find(:tube_car).get_room
      get_root.move(:player, current_station, false)
      puts current_station.short_desc
    else
      puts "Still belted up!"
    end
  SCRIPT

  item(:seatbelt, 'belt', 'seatbelt') do
    self.fixed = true
    self.short_desc = 'seat belt.'
    self.presence = "seat belt."
    self.script_fastern = <<-SCRIPT
      puts "OK"
      self.get_room.open = false
    SCRIPT
    self.script_unfastern = <<-SCRIPT
      puts "OK"
      self.get_room.open = true
    SCRIPT
  end

  item(:smallslot, 'slot') do
    self.fixed = true
    self.short_desc = "small slot."
    self.presence = "small slot"
  end
end
