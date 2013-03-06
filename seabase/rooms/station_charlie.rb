room(:station_charlie) do
  self.exit_north = :food_farm
  self.destination = :station_delta
  self.desc = <<-DESC
    I am standing on a metallic platform in a large dome. A brightly lit
    sign above the walkway says TRAVEL-TUBE STATION CHARLIE. A walkway
    leads NORTH.
  DESC
  self.short_desc = "Charlie Station."
  self.script_enter_car = <<-SCRIPT
    puts "You enter the travel-tube car"
    # TODO
  SCRIPT

  item(:lever, 'lever') do
    self.presence = "Lever"
    self.script_pull = <<-SCRIPT
      puts "Whoosh! A travel-car arrives."
      puts "The door opens"
      get_root.move(:tube_car, parent, false)
    SCRIPT
  end
  item(:rail_tracks, 'tracks', 'rail-tracks') do
    self.desc = "OUCH! Your hair stands on end!"
    self.presence = "Rail-tracks"
  end
end